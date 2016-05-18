# TryAmazonPayments

This is study coding for AmazonPayments ruby gem.
It can show how to use its gem for simple case.
Since AmazonPayments needs Amazon seller account to use sandbox, using Webmock to stub API access.

This code uses:
* PayWithAmazon::Login
  * .get_login_profile
* PayWithAmazon::Client
  * .set_order_reference_details
  * .confirm_order_reference

Live demo is here:
https://try-amazon-pay.herokuapp.com/