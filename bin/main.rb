require 'twitter'
require_relative '../lib/ruby_bot'

def get_next_mention(mentions, bot)
  file = File.open('./stored_ids.txt')
  last_id = file.read
  file.close
  mentions_ids = []
  mentions.each { |mention| mentions_ids << mention.id }
  
  return bot.tweet(last_id) unless mentions_ids.include?(last_id.to_i)

  return bot.tweet(last_id) if mentions_ids[0] == last_id.to_i

  p 'pass through here'
  mentions_ids = mentions_ids.reverse
  p mentions_ids
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
  else
    'do not reply'
  end
end
# rubocop: enable Style/EmptyCaseCondition

def store_last_id(mention)
  file = File.open('stored_ids.txt', mode: 'w')
  file.write(mention.id.to_s)
end

bot = Rubybot.new

# fecth mentions
puts 'Fetching mentions'
mentions = bot.fetch_mentions
ids = mentions.map(&:id)
p ids
# compare to last mention stored and reply to last mention
next_mention = get_next_mention(mentions, bot)
p next_mention.id
message = get_message(next_mention)
bot.reply_to(next_mention, message)
# store new last mention
store_last_id(next_mention)
