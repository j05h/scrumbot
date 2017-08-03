class Report < Sequel::Model
  def self.report(channel = nil, start_time, end_time)
    query = self.where{created_at > start_time}.where{created_at < end_time}

    if channel
      query = query.where(channel: channel)
    end

    query.all
  end

  def self.yesterday(channel = nil)
    report(channel, Time.now.yesterday.beginning_of_day, Time.now.yesterday.end_of_day)
  end

  def self.today(channel = nil)
    report(channel, Time.now.beginning_of_day, Time.now.end_of_day)
  end
end

Report.plugin :timestamps, update_on_create: true
