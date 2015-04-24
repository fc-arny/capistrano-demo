# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/demo/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-demo"
  spec.version       = Capistrano::Demo::VERSION
  spec.authors       = ["fc_arny"]
  spec.email         = ["arthur.shcheglov@gmail.com"]
  spec.summary       = %q{Create demo by branch name}
  spec.description   = %q{Create demo by branch name}
  spec.homepage      = "http://martsoft.ru"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", ">= 2.15"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.2.0"
end
