require 'twitter'

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
end
