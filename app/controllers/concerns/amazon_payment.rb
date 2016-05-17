require 'pay_with_amazon'

CLIENT_ID = 'Your Client Id'

module AmazonPayment
  extend ActiveSupport::Concern
  include AmazonPaymentStub

  def store_user_session(access_token)
    session[:access_token] = access_token
  end

  def user_profile
    binding.pry
    session[:amazon_profile] ||= amazon_login.get_login_profile(session[:access_token])
  end

  # private

  def amazon_login  # word 'login' is researved.
    binding.pry
    @amazon_login ||= PayWithAmazon::Login.new(
      CLIENT_ID,
      region: :ja,
      sandbox: true
    )
  end
end