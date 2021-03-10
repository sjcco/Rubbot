class Rubybot
  YOUR_CONSUMER_KEY = 'DISu9hfmtzmQOMQZPPcktZPmA'.freeze
  YOUR_CONSUMER_SECRET = 'hlrHzO4J49HJrDcGhTMZI73YagLcWQNEakiSAl5P71NbqFlCfF'.freeze
  YOUR_ACCESS_TOKEN = '390469327-1zaUXVOBcWY49Q5Nww7WPAjLFCEuygNg2wy95QYj'.freeze
  YOUR_ACCESS_SECRET = '7zTjZGrc8b6UP8jurvdzfldr7TIAJlmL9LHgrouJHIW8j'.freeze

  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = YOUR_CONSUMER_KEY
      config.consumer_secret = YOUR_CONSUMER_SECRET
      config.access_token = YOUR_ACCESS_TOKEN
      config.access_token_secret = YOUR_ACCESS_SECRET
    end
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
