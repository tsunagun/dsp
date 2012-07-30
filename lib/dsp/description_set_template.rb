module DSP
  class DescriptionSetTemplate
    include ActsAsRDF::Resource
    define_type RDF::OWL.Ontology
    has_object :primary_topic, RDF::REG.primaryDescription, 'DSP::DescriptionTemplate'
    has_object :creator, RDF::REG.creator, RDF::URI
    init_attribute_methods

    def build_xslt(dspfile)
      parser = self.primary_topic.getinfo
      namespaces = Nokogiri::XML.parse(open(dspfile)).namespaces
      xml = Builder::XmlMarkup.new(:indent => 2)
      xml.instruct!
      xml.xsl(:stylesheet, namespaces.merge('xmlns:xsl' => 'http://www.w3.org/1999/XSL/Transform')) {
        xml.xsl(:output, :method => 'xml', :encoding => 'UTF-8', :indent => 'yes')
        xml.xsl(:template, :match => '/') {
          xml.rdf(:RDF, namespaces) {
            xml.rdf(:Description) {
              parser.each do |dt|
                self.build_xslt_part(xml, namespaces, dt)
              end
            }
          }
        }
      }
    end

    def build_xslt_part(xml, namespaces, dt)
      dt.each do |st_uri, st_info|
        if st_info[:value].class == Array
          st_info[:value].each do |dt2|
            xml.tag!(st_info[:property].uri2prefix(namespaces)) {
              self.build_xslt_part(xml, namespaces, dt2)
            }
          end
        else
          st_info[:locations].each do |location|
            xml.xsl(:'for-each', :select => "#{location}") {
              xml.tag!(st_info[:property].uri2prefix(namespaces)) {
                xml.xsl(:'value-of', :select => '.')
              }
            }
          end
        end
      end
    end
  end
end
