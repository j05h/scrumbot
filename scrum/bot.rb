module Scrum
  class Bot < SlackRubyBot::Bot
    class << self
      attr_accessor :reports

      def bot_time
        Time.now.strftime("%Y-%m-%d")
      end
    end

    @reports = {}

    command 'help' do |client, data, match|
      message = """
Hey, I am a bot who keeps track of scrum notes! I am not really all that smart now (Thanks <@j05h>)...
By the way, I do not persist anything and I may not be stable. Will get the former, cross fingers for the latter.

Commands:
  * <@scrum> this is my status - records your daily status for <##{data.channel}>
  * report <channel> - reports the daily channel scrum (omit channel to get the local one)
  * hi - I will say hi back to you.
  * help - displays this help

If you run into bugs, yell here: https://github.com/j05h/scrumbot"""
      client.say(text: message, channel: data.channel)
    end

    command 'report' do |client, data, match|
      channel = (match['expression'] || data.channel).strip.gsub('#', '')
      channel = channel.gsub(/[<>]/, '').split("|").first # <-- shoot me

      if client.channels
        if ch = client.channels[channel]
          channel = ch.id
        else
          channel = client.channels.values.find{|v| v.name == channel}.id rescue channel
        end
      end

      channel_reports = reports[Scrum::Bot.bot_time][channel] rescue {}

      response = if channel_reports && !channel_reports.empty?
        items = channel_reports.map{|u,r| " * <@#{u}>: #{r}"}
        "Scrum report for #{Scrum::Bot.bot_time} in <##{channel}>:\n#{items.join("\n")}"

      else
        "No one has checked in at <##{channel}>."
      end
      client.say(channel: data.channel, text: response)
    end

    command 'hi', 'hello' do |client, data, match|
      client.say(channel: data.channel, text: "Hi <@#{data.user}>")
    end

    match (/^(?<bot>\S*)[\s]*(?<expression>.*)$/) do |client, data, match|
      report = match['expression']

      client.web_client.reactions_add(
        name: :white_check_mark,
        channel: data.channel,
        timestamp: data.ts,
        as_user: true)

      reports[bot_time] ||= {}
      reports[bot_time][data.channel] ||= {}
      reports[bot_time][data.channel][data.user] = report
    end
  end
end
