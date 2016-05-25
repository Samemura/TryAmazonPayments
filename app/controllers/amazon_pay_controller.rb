# https://github.com/amzn/login-and-pay-with-amazon-sdk-ruby#get-login-profile-api

class AmazonPayController < ApplicationController
  include AmazonPayment

  def login
    session.clear
  end

  def index
    # The access token is available in the return URL
    # parameters after a user has logged in.
    self.access_token = params[:access_token]
    @profile = self.user_profile
  end

  def buy
  end

  def confirm
    # These values are grabbed from the Login and Pay
    # with Amazon Address and Wallet widgets
    amazon_order_reference_id = 'AMAZON_ORDER_REFERENCE_ID'
    address_consent_token = 'ADDRESS_CONSENT_TOKEN'

    amazon_client.set_order_reference_details(
      amazon_order_reference_id,
      10000,
      seller_note: 'Note',
      seller_order_id: 'SellerOrderId',
      store_name: 'Amazon pay store'
    )

    # Make the ConfirmOrderReference API call to
    # confirm the details set in the API call
    # above.
    amazon_order_reference_id = 'AMAZON_ORDER_REFERENCE_ID'
    amazon_client.confirm_order_reference(amazon_order_reference_id)
  end
end
