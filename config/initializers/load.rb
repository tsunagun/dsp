require 'open-uri'
require 'nokogiri'
require 'linkeddata'
require 'spira'
require 'builder'
require 'rdf/reg'
require 'rdf/dsp'
require 'rdf/dxl'

Spira.add_repository! :default, RDF::Repository.new
