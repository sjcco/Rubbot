require 'twitter'
require_relative '../lib/ruby_bot'

def retrieve_id
  file = File.open('./stored_ids.txt')
  id = file.read
  file.close
  id
end

def get_next_mention(mentions, bot)
  last_id = retrieve_id
  mentions_ids = []
  mentions.each { |mention| mentions_ids << mention.id }
  return bot.tweet(last_id) unless mentions_ids.include?(last_id.to_i)

  return bot.tweet(last_id) if mentions_ids[0] == last_id.to_i

  mentions_ids = mentions_ids.reverse
  index = 0
  mentions_ids.each_with_index { |mention, indx| index = indx + 1 if mention == last_id.to_i }
  bot.tweet(mentions_ids[index])
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

def replies_to_tweets(bot)
  # fecth mentions
  puts 'Fetching mentions'
  mentions = bot.fetch_mentions
  # compare to last mention stored and reply to last mention
  next_mention = get_next_mention(mentions, bot)
  message = get_message(next_mention)
  bot.reply_to(next_mention, message)
  # store new last mention
  store_last_id(next_mention)
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
loop do
  replies_to_tweets(bot)
  follow_tweet_usr(bot)
  sleep(5)
end
