require 'twitter'
require_relative '../lib/ruby_bot'

describe Rubybot do
  describe '#initialize' do
    it 'generates new client object' do
      bot = Rubybot.new
      expect(bot.client.is_a?(Twitter::REST::Client)).to be(true)
    end
  end

  describe '#post_tweet' do
    bot = Rubybot.new
    it 'Returns tweet object' do
      expect(bot.post_tweet(rand(1..1000).to_s).class).to be(Twitter::Tweet)
    end
  end

  describe '#get_message' do
    bot = Rubybot.new
    it 'Returns hello' do
      new_tweet = bot.post_tweet("#{rand(1..1000)} #hello")
      expect(bot.get_message(new_tweet)).to eql('#Hello to you too')
    end
    it 'Returns I\'m also a robot' do
      new_tweet = bot.post_tweet("#{rand(1..1000)} #iamarobot")
      expect(bot.get_message(new_tweet)).to eql('I\'m also a Robot')
    end
    it 'Returns I\'ll follow' do
      new_tweet = bot.post_tweet("#{rand(1..1000)} #followme")
      expect(bot.get_message(new_tweet)).to eql('Yes I\'ll follow you')
    end
    it 'Returns do not reply' do
      new_tweet = bot.post_tweet("#{rand(1..1000)} dont reply")
      expect(bot.get_message(new_tweet)).to eql('do not reply')
    end
  end
end
