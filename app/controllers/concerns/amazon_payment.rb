require 'pay_with_amazon'
require 'xmlsimple'

module AmazonPayment
  SELLER_ID = ENV['SELLER_ID']
  CLIENT_ID = ENV['CLIENT_ID']
  ACCESS_KEY = ENV['ACCESS_KEY']
  SECRET_KEY = ENV['SECRET_KEY']

  extend ActiveSupport::Concern
  class Error < StandardError; end

  # Accessor
  def access_token=(token)
    session[:access_token] = token
  end
  def access_token
    session[:access_token]
  end
  def user_profile
    session[:login_profile] ||= get_login_profile(access_token)
  end
  def order_reference_id=(id)
    session[:order_reference_id] = id
  end
  def order_reference_id
    session[:order_reference_id]
  end
  def authorization_reference_id=(id)
    session[:authorization_reference_id] = id  # https://payments.amazon.com/documentation/apireference/201752010
  end
  def authorization_reference_id
    session[:authorization_reference_id]
  end
  def amazon_authorization_id=(id)
    session[:amazon_authorization_id] = id
  end
  def amazon_authorization_id
    session[:amazon_authorization_id]
  end

  # method
  def get_order_reference_details
    res = amazon_client.get_order_reference_details(order_reference_id, address_consent_token: access_token)
    if res.success
      xml_to_hash(res.body)
    else
      raise Error, "Failed get_order_reference_details"
    end
  end

  def get_authorization_details
    res =amazon_client.get_authorization_details(amazon_authorization_id)
    if res.success
      xml_to_hash(res.body)
    else
      raise Error, "Failed get_authorization_details"
    end
  end

  def set_order_reference_details(amount)
    res = amazon_client.set_order_reference_details(
      order_reference_id,
      amount,
      seller_note: 'Note',
      seller_order_id: 'SellerOrderId',
      store_name: 'Amazon pay store'
    )
    if res.success
      xml_to_hash(res.body)
    else
      raise Error, "Failed set_order_reference_details"
    end
  end

  def confirm_order_reference
    res = amazon_client.confirm_order_reference(order_reference_id)
    if res.success
      xml_to_hash(res.body)
    else
      raise Error, "Failed confirm_order_reference"
    end
  end

  def authorize(amount)
    self.authorization_reference_id = generate_authori_id
    res = amazon_client.authorize(
      order_reference_id,
      authorization_reference_id,
      amount,
      seller_authorization_note: 'Your Authorization Note',
      # for asynchronous mode # transaction_timeout: 0, # Set to 0 for synchronous mode
      capture_now: true # Set this to true if you want to capture the amount in the same API call
    )
    if res.success
      xml = xml_to_hash(res.body)
      self.amazon_authorization_id = xml[:AuthorizeResult][:AuthorizationDetails][:AmazonAuthorizationId]
      xml
    else
      raise Error, "Failed authorize"
    end
  end

  # private
  def get_login_profile(token)
    log "access token: " + token
    profile = amazon_login.get_login_profile(token).symbolize_keys
    log "user profile: " + profile.to_s
    return profile
  rescue => error
    logger.fatal error
    raise error
  end

  def xml_to_hash(xml)
    XmlSimple.xml_in(xml, ForceArray: false).deep_symbolize_keys
  end

  def generate_authori_id
    'jagmo-' + Time.now.strftime("%Y-%m-%d_%H-%M-%S-%L")
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
      region: :jp,
      currency_code: 'JPY',
      sandbox: true
    )
  end
end