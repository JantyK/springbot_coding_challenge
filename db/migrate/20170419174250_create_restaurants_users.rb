class CreateRestaurantsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants_users do |t|
      t.references :user, foreign_key: true
      t.references :restaurant, foreign_key: true
      t.date :last_visited
      t.date :last_recommended

      t.timestamps
    end
  end
end
