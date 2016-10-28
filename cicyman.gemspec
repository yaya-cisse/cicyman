# coding: utf-8
# lib = File.expand_path('../lib', __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require File.expand_path("../lib/cicyman/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "cicyman"
  spec.version       = Cicyman::VERSION
  spec.authors       = ["yaya-cisse"]
  spec.email         = ["yaya-cisse.abdelhafiz@mobile-devices.fr"]

  spec.summary       = "Cicyman a file manager gem"#%q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = "A gem to manage files using multi storage services"#%q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = Dir['lib/*.rb']+ Dir['lib/cicyman/*'] + Dir['bin/*']#{}`git ls-files`.split("\n")#{}`git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_path  = 'lib'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'mysql2', '~> 0.3.20'
  spec.add_development_dependency 'mongoid', '~> 3.1.7', '>= 3.1.7'
  # spec.add_development_dependency 'moped', '~> 2.0.0', '>= 2.0.0'
  # spec.add_development_dependency 'activemodel', '~> 3.2', '>= 3.2'
  # spec.add_development_dependency 'tzinfo', '~> 1.1.0', '>= 1.1.0'
  # spec.add_development_dependency 'origin', '~> 2.2', '>= 2.2.0'
  # spec.add_development_dependency 'bson', '~> 3.0', '>= 3.0'
  spec.add_development_dependency 'after_do', '~> 0.4.0'
  spec.add_development_dependency 'libgfapi-ruby', '~> 0.0.15'
  spec.add_development_dependency 'couchbase', '~> 1.3', '>= 1.3.14'
  spec.add_development_dependency 'couchbase-model', '~> 0.5.4'
end
