# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crisp_client/version'

Gem::Specification.new do |spec|
  spec.name          = "crisp_client"
  spec.version       = CrispClient::VERSION
  spec.authors       = ["Flavio Wuensche"]
  spec.email         = ["f.wuensche@gmail.com"]

  spec.summary       = %q{Ruby Client for Crisp API}
  spec.description   = %q{Appreciate ruby syntactic sugar while interacting with Crisp API}
  spec.homepage      = "https://github.com/fwuensche/crisp_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  # spec.add_development_dependency "byebug"
  # spec.add_development_dependency "pry"

  spec.add_dependency "httparty"
end
