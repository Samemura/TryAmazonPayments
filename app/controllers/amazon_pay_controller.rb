# https://github.com/amzn/login-and-pay-with-amazon-sdk-ruby#get-login-profile-api
USER_PROFILE = {
  name: "bob",
  email: "bob@bob.com",
  id: 11222222
}

class AmazonPayController < ApplicationController
  include AmazonPayment

  def login
  end

  def index
    # The access token is available in the return URL
    # parameters after a user has logged in.
    access_token = 'User Access Token'

    store_user_session(access_token)
    @profile = user_profile
    # @profile = USER_PROFILE
  end

  def buy

  end

  def confirm
  end
end
