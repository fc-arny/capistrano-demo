lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-demo'
  spec.version       = '0.0.7'
  spec.authors       = ['Arthur Shcheglov (fc_arny)']
  spec.email         = ['arthur.shcheglov@gmail.com']
  spec.summary       = %q{Create demo-host by branch name}
  spec.description   = %q{Create demo-host by branch name}
  spec.homepage      = 'http://at-consulting.ru'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '~> 3.1'
  # spec.add_dependency 'yaml_db', '~> 0.3.0'

  spec.add_development_dependency 'bundler', '~> 1.10.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.2.0'
end
