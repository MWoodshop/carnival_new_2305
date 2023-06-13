require 'simplecov'
SimpleCov.start
require 'rspec'
require 'pry'

require 'date'
require 'visitor'
require 'ride'
require 'carnival'

RSpec.configure do |config|
  config.formatter = :documentation
end
