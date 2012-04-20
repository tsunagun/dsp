module DSP
  class DescriptionTemplate
    include ActsAsRDF::Resource
    define_type RDF::DSP.DescriptionTemplate
    has_objects :statement_templates, RDF::RDFS.subClassOf, 'DSP::StatementTemplate'
    init_attribute_methods

    def getinfo
      self.statement_templates.map do |statement_template|
        statement_template.getinfo
      end
    end
  end
end
