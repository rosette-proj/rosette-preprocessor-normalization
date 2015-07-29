# encoding: UTF-8

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'expert'
Expert.environment.require_all

require 'pry-nav'
require 'rspec'
require 'rosette/core'
require 'rosette/preprocessors/normalization-preprocessor'

RSpec.configure do |config|
end
