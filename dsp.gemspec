# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dsp/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["tsunagun"]
  gem.email         = ["tsuna@slis.tsukuba.ac.jp"]
  gem.description   = %q{Utilities for DescriptionSetProfile}
  gem.summary       = %q{Utilities for DescriptionSetProfile}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "dsp"
  gem.require_paths = ["lib", "config"]
  gem.version       = DSP::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"
  gem.add_dependency "nokogiri"
  gem.add_dependency "equivalent-xml"
  gem.add_dependency "linkeddata"
  gem.add_dependency "builder"
  gem.add_dependency "spira"
end
