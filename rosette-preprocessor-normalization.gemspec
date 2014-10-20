$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'rosette/preprocessors/normalization-preprocessor/version'

Gem::Specification.new do |s|
  s.name     = "rosette-preprocessor-normalization"
  s.version  = ::Rosette::Preprocessors::NormalizationPreprocessor::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["camertron@gmail.com"]
  s.homepage = "http://github.com/camertron"

  s.description = s.summary = "Normalizes text for the Rosette internationalization platform."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.require_path = 'lib'
  s.files = Dir["{lib,spec}/**/*", "Gemfile", "History.txt", "README.md", "Rakefile", "rosette-preprocessor-normalization.gemspec"]
end
