# -*- coding: utf-8 -*-
module DSP
  class Namespaces
    # rdfファイルがxmlの場合のみ有効
    attr_accessor :all

    def initialize(fname)
      @all = Hash.new
      Nokogiri::XML(open(fname).read).namespaces.each do |name,uri|
        @all[name.gsub("xmlns:","")] = uri
      end
    end
  end
end
