# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'auto_api/version'

Gem::Specification.new do |spec|
  spec.name          = "auto_api"
  spec.version       = AutoApi::VERSION
  spec.authors       = ["Phillip R. Spitler (Phil)"]
  spec.email         = ["prs@sproutkey.com"]
  spec.summary       = "Automattic API Generator"
  spec.description   = "AutoApi generates a RESTful API on the fly.  If you call gets on items that do not exist, you get back what you'd expect if the object didn't exist.  If you POST to something, even if it doesn't exist, it will create it on the fly, which then can be retreived from the database.  It runs on Sinatra and MongoDB."
  spec.homepage      = "https://github.com/philspitler/auto_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'sinatra'
  spec.add_dependency 'sinatra-contrib'
  spec.add_dependency "mongoid", "~> 3.1.6"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bond" #auto completion when  running $ bundle exec irb

end
