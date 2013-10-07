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
