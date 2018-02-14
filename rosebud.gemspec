# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rosebud/version'

Gem::Specification.new do |spec|
  spec.name          = 'rosebud'
  spec.version       = Rosebud::VERSION
  spec.authors       = ['Anthony Smith']
  spec.email         = ['anthony@sticksnleaves.com']
  spec.description   = %q{Rails API parameter validation}
  spec.summary       = %q{Finally! An easy way to validate your Rails API parameters.}
  spec.homepage      = 'http://www.github.com/anthonator/rosebud'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'virtus',       '~> 1.0'
  spec.add_runtime_dependency 'errawr',       '~> 1.0'
  spec.add_runtime_dependency 'errawr-rails', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec-rails'
end
