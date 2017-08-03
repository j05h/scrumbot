require 'sinatra/base'

module Scrum
  class Web < Sinatra::Base

    def report(data)
      response = '<html><head></head><body>\n'
      data.group_by{|r| r.channel }.each do |channel, reports|
        response << "<h3>#{channel}</h3>\n"
        reports.each do |report|
          response << "<li><strong>#{report.user}</strong> : #{report.text}</li>\n"
        end
      end

      response << "</body></html>"

      response
    end

    get '/' do
      'Scrum is good for you.'
    end

    get '/today' do
      report Report.today
    end

    get '/yesterday' do
      report Report.yesterday
    end
  end
end
