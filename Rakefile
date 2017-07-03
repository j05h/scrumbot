$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv'
Dotenv.load

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end


# bundle exec rake migrate[0]
task :migrate, [:version] do |t, args|
  require 'db'
  Sequel.extension :migration

  if args[:version]
    puts "Migrating to version #{args[:version]}"
    Sequel::Migrator.run(DB, "db/migrate", target: args[:version].to_i)
  else
    puts "Migrating to latest"
    Sequel::Migrator.run(DB, "db/migrate")
  end
end
