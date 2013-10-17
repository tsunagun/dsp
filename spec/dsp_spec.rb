require 'spec_helper'
require 'dsp'

describe "DSP" do
  before do
    Spira.add_repository(:default, RDF::Repository.load(dsp_location))
    @description_set_template = DSP::DescriptionSetTemplate.for(RDF::URI.new(description_set_template_uri))
    @description_template = DSP::DescriptionTemplate.for(RDF::URI.new(description_template_uri))
    @statement_template = DSP::StatementTemplate.for(RDF::URI.new(statement_template_uri))
  end

  description_set_template_uri = "http://dandelion.slis.tsukuba.ac.jp/dsp/asahi"
  description_template_uri = "http://dandelion.slis.tsukuba.ac.jp/dsp/asahi#MAIN"
  statement_template_uri = "http://dandelion.slis.tsukuba.ac.jp/dsp/asahi#MAIN-作成者"
  #metabridge_base_uri = "http://www.metabridge.jp/infolib/metabridge/api/description?graph="
  # dsp_location = metabridge_base_uri + dsp_uri
  dsp_location = "./spec/fixtures/asahi_com_dsp.rdf"
  
  let(:description_set_template_uri) { description_set_template_uri }
  let(:description_template_uri) { description_template_uri }
  let(:statement_template_uri) { statement_template_uri }
  let(:metabridge_base_uri) { metabridge_base_uri }
  let(:dsp_location) { dsp_location }

  describe "DescriptionSetTemplate" do
    subject { @description_set_template }
    it { should be_an_instance_of(DSP::DescriptionSetTemplate) }
    its(:creator) { should be_an_instance_of(RDF::URI) }
    its(:version) { should be_an_instance_of(String) }
    its(:title) { should be_an_instance_of(String) }
    its(:comment) { should be_an_instance_of(String) }
    its(:created) { should be_an_instance_of(String) }
    its(:registered) { should be_an_instance_of(String) }
    its(:description_templates) { should be_an_instance_of(Array) }
    its(:description_templates) { should have_at_least(1).description_template }
    its(:description_templates) { should be_all {|description_template| description_template.instance_of?(DSP::DescriptionTemplate) } }
  end

  describe "DescriptionTemplate" do
    subject { @description_template }
    its(:label) { should be_an_instance_of(String) }
    its(:statement_order) { should be_an_instance_of(String) }
    its(:id_field) { should be_an_instance_of(String) }
    its(:resource_class) { should be_an_instance_of(RDF::URI) }
    its(:statement_templates) { should be_an_instance_of(Array) }
    its(:statement_templates) { should have_at_least(1).statement_template }
    its(:statement_templates) { should be_all {|statement_template| statement_template.instance_of?(DSP::StatementTemplate) } }
  end

  describe "StatementTemplate" do
    subject { @statement_template }
    its(:label) { should be_an_instance_of(String) }
  end
end
