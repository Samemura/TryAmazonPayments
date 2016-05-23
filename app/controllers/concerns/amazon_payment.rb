require 'pay_with_amazon'

module AmazonPayment
  SELLER_ID = ENV['SELLER_ID']
  CLIENT_ID = ENV['CLIENT_ID']
  ACCESS_KEY = ENV['ACCESS_KEY']
  SECRET_KEY = ENV['SECRET_KEY']

  extend ActiveSupport::Concern
  include AmazonPaymentStub

  def store_user_session(access_token)
    session[:access_token] = access_token
  end

  def user_profile
    session[:amazon_profile] ||= amazon_login.get_login_profile(session[:access_token]).symbolize_keys
  rescue => error
    logger.fatal error
  end

  # private

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