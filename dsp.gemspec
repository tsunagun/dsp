# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dsp/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["tsunagun"]
  gem.email         = ["tsuna@slis.tsukuba.ac.jp"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "dsp"
  gem.require_paths = ["lib"]
  gem.version       = Dsp::VERSION
end
