lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "omniauth-moikrug/version"

Gem::Specification.new do |gem|
  gem.add_development_dependency "bundler", "~> 1.0"

  gem.authors       = ["George Khromchenko", "Michael Bleigh", "Erik Michaels-Ober", "Tom Milewski"]
  gem.email         = ["gk@jobingood.com", "michael@intridea.com", "sferik@gmail.com", "tmilewski@gmail.com"]
  gem.description   = "MoiKrug strategy for OmniAuth."
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/moxorama/omniauth-moikrug"
  gem.licenses      = %w[MIT]

  gem.executables   = `git ls-files -- bin/*`.split("\n").collect { |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-moikrug"
  gem.require_paths = %w[lib]
  gem.version       = OmniAuth::MoiKrug::VERSION


  gem.add_dependency 'omniauth', '~> 1.5'
  gem.add_dependency 'omniauth-oauth2', '>= 1.4.0', '< 2.0'
  gem.add_development_dependency 'rspec', '~> 3.5'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
