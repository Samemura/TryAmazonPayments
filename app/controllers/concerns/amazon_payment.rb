require 'pay_with_amazon'

module AmazonPayment
  SELLER_ID = ENV['SELLER_ID']
  CLIENT_ID = ENV['CLIENT_ID']
  ACCESS_KEY = ENV['ACCESS_KEY']
  SECRET_KEY = ENV['SECRET_KEY']

  extend ActiveSupport::Concern

  def access_token=(token)
    session[:access_token] ||= token
  end

  def access_token
    session[:access_token]
  end

  def user_profile
    session[:amazon_profile] ||= get_profile(access_token)
  end

  # private

  def get_profile(token)
    profile = amazon_login.get_login_profile(token).symbolize_keys
    log "access token: " + token
    log "user profile: " + profile.to_s
    return profile
  rescue => error
    logger.fatal error
    raise error
  end

  def log(message)
    Rails.logger.info "[AmazonPay] " + message
  end

  def amazon_login  # word 'login' is researved.
    # https://github.com/amzn/login-and-pay-with-amazon-sdk-ruby/blob/master/lib/pay_with_amazon/login.rb#L14
    @amazon_login ||= PayWithAmazon::Login.new(
      CLIENT_ID,
      region: :jp,
      sandbox: true
    )
  end

  def amazon_client
    @amazon_client ||= PayWithAmazon::Client.new(
      SELLER_ID,
      ACCESS_KEY,
      SECRET_KEY,
      sandbox: true
    )
  end
end