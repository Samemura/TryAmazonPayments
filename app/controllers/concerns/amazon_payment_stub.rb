require 'webmock'
include WebMock::API

module AmazonPaymentStub
  USER_PROFILE = {
    name: "bob",
    email: "bob@bob.com",
    id: 11222222
  }

  extend ActiveSupport::Concern

  WebMock.enable!
  WebMock.after_request do |req, res|
    request = {
      method: req.method.to_s.upcase,
      uri: req.uri.to_s,
      headers: req.headers,
      body: req.body
    }
    Rails.logger.info '[Webmock] ' + req.method.to_s.upcase + ', ' + req.uri.to_s + '
      Header:' + req.headers.inspect + '
      Body:' + req.body.inspect
  end

  # login
  stub_request(:get, "https://api.sandbox.amazon.co.jp/auth/o2/tokeninfo?access_token=User%20Access%20Token").
    to_return(:status => 200, :body => {aud: AmazonPayment::CLIENT_ID}.to_json, :headers => {})

  stub_request(:get, "https://api.sandbox.amazon.co.jp/user/profile").
    to_return(:status => 200, :body => USER_PROFILE.to_json, :headers => {})

  # set order
  stub_request(:post, "https://mws.amazonservices.com/OffAmazonPayments_Sandbox/2013-01-01").
    to_return(:status => 200, :body => "", :headers => {})

end