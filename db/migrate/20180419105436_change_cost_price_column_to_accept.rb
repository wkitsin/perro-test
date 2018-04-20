class ChangeCostPriceColumnToAccept < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :cost_price, :decimal, { :scale => 3, :precision => 10 }
  end
end
