# encoding: UTF-8

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'expert'
Expert.environment.require_all

require 'rspec/core/rake_task'
require 'rubygems/package_task'

require './lib/rosette/preprocessors/normalization-preprocessor'

Bundler::GemHelper.install_tasks

task :default => :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end
