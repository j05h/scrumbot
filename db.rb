require 'sequel'

Sequel::Model.plugin :timestamps

DB = Sequel.connect(ENV['DATABASE_URL'])
