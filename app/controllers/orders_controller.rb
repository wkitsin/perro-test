class OrdersController < ApplicationController
  require 'open-uri'
  def index
     @orders = order_query

     # Calculate profits
     @profit = profit_calculation(@orders)
  end

  def order_query
    orders_url = "https://#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com/admin/orders.json"
    orders = open(orders_url, :http_basic_authentication=>["#{ENV['SHOPIFY_API_KEY']}", "#{ENV['SHOPIFY_SECRET']}"])
    orders_json = JSON.load(orders)
  end
end
