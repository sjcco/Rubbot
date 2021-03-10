require 'twitter'
require_relative '../lib/ruby_bot'

bot = Rubybot.new

# fecth mentions
mentions = bot.fetch_mentions
# compare to last mention stored and reply to last mention
next_mention = get_next_mention(mentions, bot)
message = get_message(next_mention)
bot.reply_to(next_mention, message)
# store new last mention
store_last_id(next_mention)
