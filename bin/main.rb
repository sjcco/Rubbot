require 'twitter'
require_relative '../lib/ruby_bot'

def retrieve_id
  file = File.open('stored_ids.txt')
  id = file.read
  file.close
  id
end

def store_last_id(mention)
  file = File.open('stored_ids.txt', mode: 'w')
  file.write(mention.id.to_s)
  file.close
end

bot = Rubybot.new
loop do
  bot.replies_to_tweets
  bot.follow_tweet_usr
  sleep(15)
end
