module Scrum
  class Bot < SlackRubyBot::Bot
    class << self

      def bot_time
        Time.now.strftime("%Y-%m-%d")
      end

      def report(channel_reports, client, data)

        response = ""
        if channel_reports && !channel_reports.empty?
          channel_reports.each do |channel, reports|
            items = reports.map{|r| " * <@#{r.user}>: #{r.text}"}
            response << "\n\nScrum report for #{Scrum::Bot.bot_time} in <##{channel}>:\n#{items.join("\n")}"
          end
        else
          "No one has checked in at Today"
        end
        client.say(channel: data.channel, text: response)
      end

    end

    command 'help' do |client, data, match|
      message = """
Hey, I am a bot who keeps track of scrum notes!

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

      channel_reports = Report.today(channel)

      response = if channel_reports && !channel_reports.empty?
        items = channel_reports.map{|r| " * <@#{r.user}>: #{r.text}"}
        "\n\nScrum report for #{Scrum::Bot.bot_time} in <##{channel}>:\n#{items.join("\n")}"

      else
        "No one has checked in at <##{channel}>."
      end
      client.say(channel: data.channel, text: response)
    end

    command 'today' do |client, data, match|
      report Report.today.group_by{|r| r.channel}, client, data
    end

    command 'yesterday' do |client, data, match|
      report Report.yesterday.group_by{|r| r.channel}, client, data
    end

    command 'hi', 'hello' do |client, data, match|
      client.say(channel: data.channel, text: "Hi <@#{data.user}>")
    end

    match (/^(?<bot>\S*)[\s]*(?<expression>.*)$/) do |client, data, match|
      text = match['expression']

      client.web_client.reactions_add(
        name: :white_check_mark,
        channel: data.channel,
        timestamp: data.ts,
        as_user: true)

      report = Report.create(text: text, channel: data.channel, user: data.user)
    end
  end
end
