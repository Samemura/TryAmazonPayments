# https://github.com/amzn/login-and-pay-with-amazon-sdk-ruby#get-login-profile-api

class AmazonPayController < ApplicationController
  include AmazonPayment
  helper_method :access_token, :user_profile
  before_action :store_parameter

  def login
    session.clear
  end

  def index
  end

  def buy
  end

  def confirm
    # These values are grabbed from the Login and Pay
    # with Amazon Address and Wallet widgets
    Rails.logger.info get_order_reference_details[:GetOrderReferenceDetailsResult][:OrderReferenceDetails][:Destination][:PhysicalDestination]

    amount = 10000
    set_order_reference_details(amount)
    confirm_order_reference
    authorize(amount)

    Rails.logger.info get_authorization_details
  end

  private

  def store_parameter
    # The access token is available in the return URL
    # parameters after a user has logged in.
    self.access_token = params[:access_token] if params[:access_token].present?
    self.order_reference_id = params[:order_reference_id] if params[:order_reference_id].present?
  end
end
