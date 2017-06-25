require 'simplecov'

SimpleCov.start do
  minimum_coverage 51
end

require 'rspec'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.order = 'default'
end
