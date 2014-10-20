# encoding: UTF-8

require 'pry-nav'

require 'jbundler'
require 'rspec'
require 'rosette/core'
require 'rosette/preprocessors/normalization-preprocessor'

RSpec.configure do |config|
  config.mock_with :rr
end
