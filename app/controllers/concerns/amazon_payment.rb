require 'pay_with_amazon'

module AmazonPayment
  CLIENT_ID = 'CLIENT_ID'
  USER_PROFILE = {
    name: "bob",
    email: "bob@bob.com",
    id: 11222222
  }

  extend ActiveSupport::Concern
  include AmazonPaymentStub

  def store_user_session(access_token)
    session[:access_token] = access_token
  end

  def user_profile
    session[:amazon_profile] ||= amazon_login.get_login_profile(session[:access_token])
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
end