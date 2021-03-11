require 'twitter'
require_relative '../lib/ruby_bot'

def retrieve_id
  file = File.open('./stored_ids.txt')
  id = file.read
  file.close
  id
end

# rubocop: disable Style/EmptyCaseCondition
def get_message(mention)
  case
  when mention.text.downcase.match?(/#hello/)
    '#Hello to you too'
  when mention.text.downcase.match?(/#iamarobot/)
    'I\'m also a Robot'
  when mention.text.downcase.match?(/#followme/)
    'Yes I\'ll follow you'
  else
    'do not reply'
  end
end
# rubocop: enable Style/EmptyCaseCondition

def store_last_id(mention)
  file = File.open('stored_ids.txt', mode: 'w')
  file.write(mention.id.to_s)
  file.close
end

def follow_tweet_usr(bot)
  id = retrieve_id
  new_tweet = bot.tweet(id.to_i)
  user = new_tweet.user
  if new_tweet.text.downcase.match?(/#followme/)
    bot.my_follow(user)
    puts "Now following #{user.screen_name}"
  else
    puts 'No one to follow'
  end
end

bot = Rubybot.new

  bot.replies_to_tweets
  follow_tweet_usr(bot)
  sleep(5)

