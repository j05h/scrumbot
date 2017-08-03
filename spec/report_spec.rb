require 'spec_helper'

describe Report do
  def app
    Report
  end

  subject { app }

  before do
    Report.create(text: 'text', channel: 'channel1', user: 'user1')
    Report.create(text: 'text', channel: 'channel1', user: 'user2')
    Report.create(text: 'text', channel: 'channel2', user: 'user3')
    Report.create(text: 'text', channel: 'channel2', user: 'user4')
  end

  it 'pulls everything for today' do
    expect(Report.today.size).to eq(4)
  end

  it 'pulls just the channel' do
    expect(Report.today('channel1').size).to eq(2)
  end
end
