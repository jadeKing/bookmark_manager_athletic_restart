require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'data_mapper'
require_relative './app/data_mapper_setup'

RuboCop::RakeTask.new :cop
RSpec::Core::RakeTask.new :spec

task default: [:cop, :spec]

task :auto_upgrade do
  # makes non-destructive changes, table created if non-existent
  # if table exists & schema has been changed it won't upgrade
  DataMapper.auto_upgrade!
  puts 'Auto-upgrade complete (no data loss)'
end

task :auto_migrate do
  # creates table with changes regardless of data loss
  DataMapper.auto_migrate!
  puts 'Auto-migrate complete (data could have been lost)'
end
