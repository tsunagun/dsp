# Dsp

DCMI Description Set ProfileをRubyで扱うためのユーティリティー群

## Installation

Add this line to your application's Gemfile:

    gem 'dsp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dsp

## Usage

    require 'dsp'
    dspfile = "http://dandelion.slis.tsukuba.ac.jp/dsp/asahi"
    dst_uri = dspfile
    ActsAsRDF.repository = RDF::Repository.load(dspfile)
    dst = DSP::DescriptionSetTemplate.find(RDF::URI.new('dst_uri'))
    dts = dst.description_templates
    sts = dts.first.statement_templates

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
