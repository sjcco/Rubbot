class Rubybot
  YOUR_CONSUMER_KEY = 'vx3CzTc4Q6bgeRWmX79T4EJz7'.freeze
  YOUR_CONSUMER_SECRET = '0UntASFKBPEf10PnfHzeYmloxtUg43GxWofdXWCUdu3ajTLIZd'.freeze
  YOUR_ACCESS_TOKEN = '1369413900165320705-hPM1dZOnfOkEk8vOz7oqRRBaYhdrbK'.freeze
  YOUR_ACCESS_SECRET = 'nkiimRvwrYQvIVWiGzgxy3sDKNkOANFiFlpKOZdsj6Fm9'.freeze

  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = YOUR_CONSUMER_KEY
      config.consumer_secret = YOUR_CONSUMER_SECRET
      config.access_token = YOUR_ACCESS_TOKEN
      config.access_token_secret = YOUR_ACCESS_SECRET
    end
    @mentions = []
  end

  def replies_to_tweets
    puts 'Fetching mentions'
    last_id = retrieve_id
    mentions_ids = @mentions.map(&:id)
    @mentions = fetch_mentions if @mentions.empty? || mentions_ids[0] == last_id.to_i
    next_mention = get_next_mention(@mentions)
    message = get_message(next_mention)
    reply_to(next_mention, message)
    store_last_id(next_mention)
  end

  def follow_tweet_usr
    id = retrieve_id
    new_tweet = tweet(id.to_i)
    user = new_tweet.user
    if new_tweet.text.downcase.match?(/#followme/)
      bot.my_follow(user)
      puts "Now following #{user.screen_name}"
    else
      puts 'No one to follow'
    end
  end

  def get_next_mention(mentions)
    last_id = retrieve_id
    mentions_ids = mentions.map(&:id)
    return tweet(last_id) unless mentions_ids.include?(last_id.to_i)

    return tweet(last_id) if mentions_ids[0] == last_id.to_i

    mentions_ids = mentions_ids.reverse
    index = 0
    mentions_ids.each_with_index { |mention, indx| index = indx + 1 if mention == last_id.to_i }
    tweet(mentions_ids[index])
  end

  def reply_to(last_mention, message)
    if message != 'do not reply'
      puts 'Replied message to user'
      @client.update("@#{last_mention.user.screen_name} #{message}", { in_reply_to_status_id: last_mention.id })
    else
      puts "Did not reply to - #{last_mention.id}"
    end
  end

  def fetch_mentions
    @client.mentions_timeline
  end

  def tweet(id)
    @client.status(id)
  end

  def my_follow(user_id)
    @client.follow(user_id)
  end
end
