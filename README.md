# DSP

Utilities for Dublin Core Description Set Profile.

Function 1: Parse DSP to three class.
  DSP::DescriptionSetTemplate
  DSP::DescriptionTemplate
  DSP::StatementTemplate


## Installation

    gem build dsp.gemspec
    gem install dsp-0.0.2.gem

## Usage

### Parse Description Set Profile
    require 'dsp'
    dsp_uri = "http://dandelion.slis.tsukuba.ac.jp/dsp/asahi"
    metabridge_base_uri = "http://www.metabridge.jp/infolib/metabridge/api/description?graph="
    Spira.add_repository(:default, RDF::Repository.load(metabridge_base_uri + dsp_uri))	
    dst = DSP::DescriptionSetTemplate.for(RDF::URI.new(dsp_uri))
    dt = dst.primary_topic
    sts = dt.statement_templates


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
