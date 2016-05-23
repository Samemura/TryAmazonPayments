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
* CLIENT_ID: Described in Seller Central web configuration for your app.
* SELLER_ID: Received email for account registration from Amazon. Also called marchant ID.
* CALLBACK_URL: URL to be moved after log in with Amazon.

Live demo is here:
https://try-amazon-pay.herokuapp.com/