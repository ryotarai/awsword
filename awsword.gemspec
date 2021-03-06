# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'awsword/version'

Gem::Specification.new do |spec|
  spec.name          = "awsword"
  spec.version       = Awsword::VERSION
  spec.authors       = ["Ryota Arai"]
  spec.email         = ["ryota-arai@cookpad.com"]
  spec.summary       = %q{Sword for AWS}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "ox"
  spec.add_dependency "aws-sdk", "~> 2.0.0"
  spec.add_dependency "hashie"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
