$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'slack-ruby-bot/rspec'
require 'not_respond'
require 'have_reactions'
require 'scrumbot'

RSpec.configure do |c|
  c.around(:each) do |example|
    Sequel::Model.db.transaction(rollback: :always, auto_savepoint: true){example.run}
  end
end
