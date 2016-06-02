source 'https://rubygems.org'

#general
gem 'rails', '4.2.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'config'
gem 'sprockets-rails'
gem 'unicorn'
gem 'smarter_csv'
gem 'hashie'
gem 'webmock'
gem 'httplog'

# front development
# gem 'turbolinks'
gem 'slim-rails'
gem 'html2slim'
gem 'autoprefixer-rails'
gem 'sass-globbing'

# Amazon
gem 'pay_with_amazon', :git => 'https://github.com/Samemura/login-and-pay-with-amazon-sdk-ruby.git'
gem 'xml-simple', '~> 1.1', '>= 1.1.5'

group :development, :test do
  gem 'dotenv-rails'
  gem 'sqlite3'
  gem 'rspec-rails'
  # gem 'spring'
  # gem 'spring-commands-rspec'
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'better_errors'
  gem 'binding_of_caller'
end

# Heroku
group :production do
  gem 'pg'
  gem 'rails_12factor'
end