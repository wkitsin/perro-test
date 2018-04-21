class ProductsController < ApplicationController

  require 'open-uri'
  before_action :authenticate_user!
  def index
    # Shopify API calls to obtain all prodcuts
    products = product_query

    # Create Products
    create_api(products)

    #index.html.erb variables
    @products = Product.order(:id)
    @product = Product.new

  end

  def update
    product = Product.find(params[:id])
    update = product.update(cost_price_params)
    if update
      flash[:success] = 'Cost price successfully saved'
    else
      flash[:error] = 'error saving cost price'
    end

    redirect_to root_path
  end

  # finds whether the products is already in the database, if no, create the product
  def create_api(products)
    products.each do |i|
      if Product.find_by_product_id(i.id) == nil
        Product.create(
          product_id: i.id,
          title: i.title,
          vendor: i.vendor,
          retail_price: i.variants[0].price
        )
      end
    end
  end

  def product_query
    shop_url = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_SECRET']}@#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current
    products_json = ShopifyAPI::Product.all

    return products_json
  end

  private

  def cost_price_params
    params.require(:product).permit(:cost_price)
  end
end
