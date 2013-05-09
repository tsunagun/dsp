# coding: UTF-8
module DSP
  class StatementTemplate < Spira::Base
    include Spira::Resource
    property :on_property, :predicate => RDF::OWL.onProperty, :type => RDF::URI
    property :on_data_range, :predicate => RDF::OWL.onDataRange, :type => RDF::URI
    property :label, :predicate => RDF::RDFS.label, :type => String
    property :qualified_cardinality, :predicate => RDF::OWL.qualifiedCardinality, :type => Integer
    property :max_qualified_cardinality, :predicate => RDF::OWL.maxQualifiedCardinality, :type => Integer
    property :min_qualified_cardinality, :predicate => RDF::OWL.minQualifiedCardinality, :type => Integer
    has_many :statement_templates, :predicate => RDF::RDFS.subClassOf, :type => "DSP::StatementTemplate"


    # StatementTemplateのowl:onClassを取得する
    # 参照値の場合 => owl:oneOfの先にあるクラスを取得
    # リソースを持つ構造化、または空ノードの場合 => DSP::DescriptionTemplateを返す
    def on_class
      klass = get_on_class(self)
      return nil if klass.nil?
      return klass if klass.class.to_s == "DSP::DescriptionTemplate"
      collection = get_collection(klass)
      return collection.empty? ? [klass] : collection
    end

    # 与えられたノードからowl:onClassを辿った先にあるノードを取得する
    def get_on_class(node)
      # リソースを持つ構造化の場合
      query = RDF::Query.new do
        pattern [node.uri, RDF::OWL.onClass, :klass]
        pattern [:klass, RDF::DSP.resourceClass, :resource_class]
      end
      query.execute(Spira.repository(:default)).each do |solution|
        return RDF::URI(solution.klass).as(DescriptionTemplate)
      end
      # 参照値の場合
      query = RDF::Query.new do
        pattern [node.uri, RDF::OWL.onClass, :klass]
        pattern [:klass, RDF::OWL.oneOf, :one_of]
      end
      query.execute(Spira.repository(:default)).each do |solution|
        return solution.klass
      end
      # 空白ノードの場合
      query = RDF::Query.new do
        pattern [node.uri, RDF::OWL.onClass, :klass]
      end
      query.execute(Spira.repository(:default)).each do |solution|
        return RDF::URI(solution.klass).as(DescriptionTemplate)
      end
      return nil
    end

    # 参照値の場合
    # 与えられたノードからowl:oneOfを辿った先にあるオブジェクトノードを取得する
    def get_one_of(node)
      query = RDF::Query.new do
        pattern [node, RDF::OWL.oneOf, :collection]
      end
      query.execute(Spira.repository(:default)).each do |solution|
        return solution.collection
      end
      return nil
    end

    # 参照値の場合
    # 与えられたノードからowl:oneOfを辿った先を起点として，コレクション構成ノードの配列を取得する
    def get_collection(klass)
      node = get_one_of(klass)
      return [] if node == []
      result = Array.new
      loop do
        first, rest = get_collection_element(node)
        result << first.last
        break if rest == RDF.nil
        node = rest
      end
      return result
    end

    # 参照値の場合
    # 与えられたコレクション構成ノードの値と次のノードを取得する
    def get_collection_element(node)
      query = RDF::Query.new do
        pattern [node, RDF.first, :first]
        pattern [node, RDF.rest, :rest]
      end
      query.execute(Spira.repository(:default)).each do |solution|
        return [solution.first, solution.rest]
      end
    end

    #define_type RDF::DSP.StatementTemplate
    #has_subject :description_template, RDF::RDFS.subClassOf, 'DSP::DescriptionTemplate'
  end
end
