class ChangeDecimalOnRestaurantsTable < ActiveRecord::Migration[5.0]
  def change
    change_column :restaurants, :average_rating, :decimal, precision: 2, scale: 1
  end
end
