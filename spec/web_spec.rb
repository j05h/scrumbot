require 'spec_helper'

describe Scrum::Web do
  def app
    Scrum::Web
  end

  subject{ app }

  before do
    Report.create(text: 'text', channel: 'channel1', user: 'user1')
    Report.create(text: 'text', channel: 'channel1', user: 'user2')
    Report.create(text: 'text', channel: 'channel2', user: 'user3')
    Report.create(text: 'text', channel: 'channel2', user: 'user4')
  end

  it 'returns all the things' do
    get '/today'

    puts last_response.body

    expect(last_response).to be_ok
  end
end
