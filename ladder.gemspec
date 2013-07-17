# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ladder/version'

Gem::Specification.new do |spec|
  spec.name          = "ladder"
  spec.version       = Ladder::VERSION
  spec.authors       = ["Christopher"]
  spec.email         = ["ChrisKnight.mail@gmail.com"]
  spec.description   = %q{TheClymb Product List}
  spec.summary       = %q{TheClymbs Daily Deals}
  spec.homepage      = "http://nomadicKnight.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ["clymb"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor', '~> 0.18.1'
  spec.add_dependency 'nokogiri', '~> 1.6.0'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end