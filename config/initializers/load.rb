require 'open-uri'
require 'nokogiri'
require 'linkeddata'
require 'acts_as_rdf'
require 'builder'
require 'rdf/reg'
require 'rdf/dsp'
require 'rdf/dxl'

ActsAsRDF.repository = RDF::Repository.new
