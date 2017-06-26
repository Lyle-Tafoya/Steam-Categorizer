require 'bundler/gem_tasks'

begin
  require 'rake/testtask'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  desc 'Runs code coverage'
  task :rcov do
    ENV['COVERAGE'] = 'true'
    Rake::Task[:spec].invoke
  end
rescue LoadError
  puts "RSpec is not installed, please run `bundle install` in order to execute unit test tasks"
end

begin
  require 'rubocop/rake_task'
  desc 'Run RuboCop on the lib directory'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.patterns = ['lib/**/*.rb']
    task.fail_on_error = false
  end
rescue LoadError
  puts "RuboCop is not installed, please run `bundle install` in order to execute RuboCop tasks"
end

if defined?(RuboCop::RakeTask)
  task default: [:rubocop, :spec]
else
  task :default do
    puts 'The default task runs RSpec unit tests and RuboCop if they are installed.  Otherwise it prints this message.'
  end
end
