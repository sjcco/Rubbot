require 'twitter'
require_relative '../lib/ruby_bot'

describe Rubybot do
  describe '#initialize' do
    it 'generates new client object' do
      bot = Rubybot.new
      expect(bot.client.is_a?(Twitter::REST::Client)).to be(true)
    end
  end

  describe '#reply_to' do
    bot = Rubybot.new
    rspec_tweet = 1_369_754_168_685_166_593
    context 'When a message is replied' do
      it 'Replies one of the premade messages' do
        tweet = bot.reply_to(bot.tweet(rspec_tweet), 'rspec test')
        expect(tweet.class).to be(Twitter::Tweet)
      end
    end
    context 'When no message is replied' do
      it 'Does not replies message' do
        tweet = bot.reply_to(bot.tweet(rspec_tweet), 'do not reply')
        expect(tweet.class).to be(nil.class)
      end
    end
  end

  describe '#fetch_mentions' do
    bot = Rubybot.new
    it 'Returns an array' do
      expect(bot.fetch_mentions.class).to be(Array)
    end
    it 'Array is composed of tweet objects' do
      expect(bot.fetch_mentions.all?(Twitter::Tweet)).to be(true)
    end
  end
end
