require 'sequel'

Sequel::Model.plugin :timestamps

DB = Sequel.mysql2(host: ENV['DB_HOST'], database: ENV['DB_SCHEMA'], user: ENV['DB_USER'], password: ENV['DB_PASS'])
