class Report < Sequel::Model
  def self.today(channel)
    self.where(channel: channel).where{created_at > Time.now.beginning_of_day}.all
  end
end

Report.plugin :timestamps, update_con_create: true
