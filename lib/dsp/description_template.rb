module DSP
  class DescriptionTemplate < Spira::Base

    include Spira::Resource
    has_many :statement_templates, :predicate => RDF::RDFS.subClassOf, :type => "DSP::StatementTemplate"
    property :label, :predicate => RDF::RDFS.label, :type => String
    property :statement_order, :predicate => RDF::REG.statementOrder, :type => String
    property :id_field, :predicate => RDF::REG.idField, :type => String
    property :resource_class, :predicate => RDF::DSP.resourceClass, :type => RDF::URI
    #define_type RDF::DSP.DescriptionTemplate

  end
end
