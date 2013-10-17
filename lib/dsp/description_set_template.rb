# -*- coding: utf-8 -*-
module DSP
  class DescriptionSetTemplate < Spira::Base
    include Spira::Resource
    property :primary_topic, :predicate => RDF::REG.primaryDescription, :type => "DSP::DescriptionTemplate"
    property :creator, :predicate => RDF::REG.creator, :type => RDF::URI
    property :version, :predicate => RDF::REG.version, :type => String
    property :title, :predicate => RDF::REG.title, :type => String
    property :comment, :predicate => RDF::REG.comment, :type => String
    property :created, :predicate => RDF::REG.created, :type => String
    property :registered, :predicate => RDF::REG.registered, :type => String
    #define_type RDF::OWL.Ontology

    # 当該DSPに含まれるDescription Templateの配列を取得する
    # 返値: DSP::DescriptionTemplateクラスのインスタンスを要素とする配列
    def description_templates
      sparql =<<-EOF
SELECT distinct ?description_template_uri
WHERE {
  ?description_template_uri a <http://purl.org/metainfo/terms/dsp#DescriptionTemplate> .
}
      EOF
      description_templates = SPARQL.execute(sparql, Spira.repository(:default)).map do |solution|
        ::DSP::DescriptionTemplate.for(RDF::URI.new(solution.description_template_uri))
      end
      return description_templates
    end

    # rdfファイルがxmlの場合のみ有効
    def namespaces(fname)
      namespaces = Hash.new
      Nokogiri::XML(open(fname).read).namespaces.each do |name,uri|
        namespaces[name.gsub("xmlns:","")] = uri
      end
      return namespaces
    end
  end
end
