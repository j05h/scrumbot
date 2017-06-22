require 'sinatra/base'

module Scrum
  class Web < Sinatra::Base
    get '/' do
      'Scrum is good for you.'
    end
  end
end
