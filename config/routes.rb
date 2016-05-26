Rails.application.routes.draw do
  root 'amazon_pay#login'
  get 'index' => 'amazon_pay#index'
  get 'buy' => 'amazon_pay#buy'
  post 'confirm' => 'amazon_pay#confirm'
end
