require 'webmock'
include WebMock::API

module AmazonPaymentStub
  extend ActiveSupport::Concern

  WebMock.enable!

  stub_request(:get, "https://api.sandbox.amazon.co.jp/auth/o2/tokeninfo?access_token=User%20Access%20Token").
    to_return(:status => 200, :body => {aud: AmazonPayment::CLIENT_ID}.to_json, :headers => {})

  stub_request(:get, "https://api.sandbox.amazon.co.jp/user/profile").
    to_return(:status => 200, :body => AmazonPayment::USER_PROFILE.to_json, :headers => {})
end