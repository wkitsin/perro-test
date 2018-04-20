class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  def profit_calculation(stats)
    @profit = []
    stats['orders'].each do |i|
      @cost = 0
      total_price = i['total_price']
      @cost = find_product_cost_price(i['line_items'], @cost)
      @profit << total_price.to_f - @cost.to_f
    end
    return @profit
  end


  def find_product_cost_price(line, cost)

    line.each do |j|
      prod = Product.find_by_product_id(j['product_id'])
      if prod.cost_price != nil
        cost = cost + (prod.cost_price * j['quantity'])
      else
        cost = 0
        return cost
      end
    end

    return cost
  end

end
