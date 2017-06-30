# Lifted from: https://github.com/slack-ruby/slack-ruby-bot/blob/master/lib/slack-ruby-bot/rspec/support/slack-ruby-bot/not_respond.rb

require 'rspec/expectations'

RSpec::Matchers.define :have_reactions do |expected|
  match do |actual|
    client = if respond_to?(:client)
               send(:client)
             else
               SlackRubyBot::Client.new
             end

    message_command = SlackRubyBot::Hooks::Message.new
    channel, user, message = parse(actual)

    expect(client.web_client).to receive(:reactions_add).with(channel: channel, name: expected, as_user: true, timestamp: nil)
    message_command.call(client, Hashie::Mash.new(text: message, channel: channel, user: user))
    true
  end

  private

  def parse(actual)
    actual = { message: actual } unless actual.is_a?(Hash)
    [actual[:channel] || 'channel', actual[:user] || 'user', actual[:message]]
  end
end

