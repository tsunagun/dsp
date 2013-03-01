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
    # owl:onClassの先がURIを持つリソースである場合と，URIを持たない空ノードである場合の両者に対応
    # 以下の2パターンの構造に対応
    #   st -> owl:onClass -> :class
    #   st -> owl:onClass -> :bnode(collection) -> owl:oneOf -> :class
    def on_class
      klass = get_on_class(self)
      return nil if klass.nil?
      collection = get_collection(klass)
      return collection.empty? ? [klass] : collection
    end

    # 与えられたノードからowl:onClassを辿った先にあるノードを取得する
    def get_on_class(node)
      query = RDF::Query.new do
        pattern [node.uri, RDF::OWL.onClass, :klass]
      end
      query.execute(Spira.repository(:default)).each do |solution|
        return solution.klass
      end
      return nil
    end

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
