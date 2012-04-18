require "dsp/version"

module Dsp
  # Your code goes here...
end

class String
  # URIの一部を名前空間接頭辞に置き換える
  # @example
  #   uri = "http://prul.org/dc/elements/1.1/title"
  #   namespaces = {"dc" => "http://purl.org/dc/elements/1.1/"}
  #   puts uri.uri2prefix(namespaces)
  #   #=> dc:title
  # @params [Hash] namespaces 名前空間接頭辞をkey，名前空間URIをvalueとしたHash
  def uri2prefix(namespaces)
    namespaces.each do |prefix, prefix_uri|
      return self.gsub(prefix_uri, prefix.gsub('xmlns:', '') + ':') if self[prefix_uri]
    end
    return self
  end
end
