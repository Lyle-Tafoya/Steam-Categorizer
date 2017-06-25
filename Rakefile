require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc 'Run RuboCop on the lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  task.fail_on_error = false
end

task default: [:rubocop, :spec]

desc 'Runs code coverage'
task :rcov do
  ENV['COVERAGE'] = 'true'
  Rake::Task[:spec].invoke
end
