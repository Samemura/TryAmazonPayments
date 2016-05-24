require 'webmock'
include WebMock::API

USER_PROFILE = {
  name: "bob",
  email: "bob@bob.com",
  id: 11222222
}

if ENV['STUB'] == 'true'
  WebMock.enable!
  puts 'WebMock enabled!'
end

WebMock.after_request do |req, res|
  Rails.logger.info '[Webmock] ' + req.method.to_s.upcase + ', ' + req.uri.to_s + '
    Header:' + req.headers.inspect + '
    Body:' + req.body.inspect
end

# login
url = Regexp.escape("https://api.sandbox.amazon.co.jp/auth/o2/tokeninfo")
stub_request(:get, /#{url}.*/i).
  to_return(:status => 200, :body => {aud: AmazonPayment::CLIENT_ID}.to_json, :headers => {})

url = Regexp.escape("https://api.sandbox.amazon.co.jp/user/profile")
stub_request(:get, /#{url}.*/i).
  to_return(:status => 200, :body => USER_PROFILE.to_json, :headers => {})

# set order
stub_request(:post, "https://mws.amazonservices.com/OffAmazonPayments_Sandbox/2013-01-01").
  to_return(:status => 200, :body => "", :headers => {})
