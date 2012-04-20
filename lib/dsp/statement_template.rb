module DSP
  class StatementTemplate
    include ActsAsRDF::Resource
    define_type RDF::DSP.StatementTemplate
    has_subject :description_template, RDF::RDFS.subClassOf, 'DSP::DescriptionTemplate'
    has_object :on_property, RDF::OWL.onProperty, RDF::URI
    has_object :on_class, RDF::OWL.onClass, 'DSP::DescriptionTemplate'
    has_object :on_data_range, RDF::OWL.onDataRange, RDF::URI
    has_objects :locations, RDF::DXL.location, RDF::URI
    init_attribute_methods

    # StatementTemplateで定義されたプロパティ，レンジ(値域, 値制約)をHashで取得する
    # {
    #   statement_template_uri => {
    #     :property => property_uri,
    #     :value => value_range_uri
    #   }
    # }
    # 構造化項目にも一部対応
    # {
    #   statement_template1_uri => {
    #     :property => property_uri,
    #     :value => [
    #       {
    #         statement_template2_uri => {
    #           :property => property_uri,
    #           :value => value_range_uri
    #         },
    #         statement_template3_uri => {...}
    #       }
    #     ]
    #   }
    # }
    def getinfo
      h = Hash.new
      value_class_uri = self.on_class.blank? ? nil : self.on_class.uri
      value_range_uri = self.on_data_range.blank? ? nil : self.on_data_range
      value_uri = (value_class_uri || value_range_uri)
      if value_uri.blank? || value_uri == RDF::RDFS.Literal
        # StatementTemplateのrangeが指定されていない，あるいはrangeがrdfs:Literalである
        h[self.uri.to_s] = {
          :property => self.on_property.to_s,
          :value => RDF::RDFS.Literal.to_s,
          :locations => self.locations.map do |location| location.to_s end
        }
      elsif self.description_template.uri == value_uri
        # StatementTemplateのdomainとrangeが同じクラスである
        h[self.uri.to_s] = {
          :property => self.on_property.to_s,
          :value => value_uri.to_s,
          :locations => self.locations.map do |location| location.to_s end
        }
      else
        dt = DescriptionTemplate.find(value_uri)
        if dt == nil
          h[self.uri.to_s] = {
            :property => self.on_property.to_s,
            :value => value_uri.to_s,
            :locations => self.locations.map do |location| location.to_s end
          }
        else
          h[self.uri.to_s] = {
            :property => self.on_property.to_s,
            :value => dt.getinfo
          }
        end
      end
      return h
    end
  end
end
