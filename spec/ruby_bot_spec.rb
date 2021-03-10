require 'twitter'
require_relative '../lib/ruby_bot'


describe Rubybot do
  describe '#initialize' do
    it 'generates new client object' do
      bot = Rubybot.new
      expect(bot.client.is_a?(Twitter::REST::Client)).to be(true)
    end
  end
end
