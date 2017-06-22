require 'spec_helper'

describe Scrum::Bot do
  def app
    Scrum::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'

  context 'a report happened' do
    before do
      @report = "working on things and whatnot today"
      expect(message: "#{SlackRubyBot.config.user} #{@report}", channel: 'channel').to respond_with_slack_message(":white_check_mark:")
    end

    it 'responds with a report for the right channel' do
      response = "Scrum report for #{Scrum::Bot.bot_time} in <@channel>:\n * <@user>: #{@report}"
      expect(message: "#{SlackRubyBot.config.user} report #channel", channel: 'channel').to respond_with_slack_message(response)
    end

    it 'does not respond if no channel exists' do
      response = "No one has checked in at <#another-channel>."
      expect(message: "#{SlackRubyBot.config.user} report #another-channel", channel: 'channel').to respond_with_slack_message(response)
    end
  end

  it 'responds to hello' do
    expect(message: "#{SlackRubyBot.config.user} hi", channel: 'channel').to respond_with_slack_message("Hi <@user>")
  end

  it 'does not respond if not asked' do
    expect(message: "what's up there bot?", channel: 'channel').to not_respond
  end

  it 'does not respond if someone else was told to' do
    expect(message: "@someone hi there", channel: 'channel').to not_respond
  end

  it 'does not respond if @here was told to' do
    expect(message: "@here this is a thing that happened", channel: 'channel').to not_respond
  end
end
