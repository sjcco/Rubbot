require_relative '../lib/ruby_bot'
require twitter

describe Rubybot do
  describe '#initialize' do
    it 'generates new client object' do
      bot = Rubybot.new
      expect(bot.client.is_a?(Twitter::REST::Client)).to be(true)
    end
  end
end
