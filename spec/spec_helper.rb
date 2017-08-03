$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'slack-ruby-bot/rspec'
require 'not_respond'
require 'have_reactions'
require 'scrumbot'
require 'web'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure do |c|
  c.include RSpecMixin
  c.around(:each) do |example|
    Sequel::Model.db.transaction(rollback: :always, auto_savepoint: true){example.run}
  end
end
