# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hedis/version'

Gem::Specification.new do |spec|
  spec.name          = "hedis"
  spec.version       = Hedis::VERSION
  spec.authors       = ["André Bernardes"]
  spec.email         = ["abernardes@gmail.com"]
  spec.summary       = %q{Redis storage of Ruby hashes}
  spec.description   = %q{Storage and searching of Ruby hashes in redis databases}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_dependency "ohm"
end
