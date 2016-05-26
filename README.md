# TryAmazonPayments

This is study coding for AmazonPayments ruby gem. (https://github.com/amzn/login-and-pay-with-amazon-sdk-ruby)
It can show how to use its gem for simple case.
Since AmazonPayments needs Amazon seller account to use sandbox, using Webmock to stub API access.

This code uses:
* PayWithAmazon::Login
  * .get_login_profile
* PayWithAmazon::Client
  * .set_order_reference_details
  * .confirm_order_reference

Environtment variables:
For development, dotenv-rails is used so refer to .env.default for the detail.

Live demo is here:
https://try-amazon-pay.herokuapp.com/

AmazonPayments needs javascript to invole Login with Amazon button but not so clear in Integration guide.
Below generator is big benefit.
http://johna1203.github.io/pwa-widget-generator/