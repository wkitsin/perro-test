class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :product_id, limit: 8
      t.string :title
      t.string :retail_price
      t.string :vendor
      t.integer :cost_price
      t.timestamps
    end
  end
end
