$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv'
Dotenv.load

require 'scrumbot'
require 'web'
require 'db'

Thread.abort_on_exception = true

Thread.new do
  begin
    Scrum::Bot.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run Scrum::Web
