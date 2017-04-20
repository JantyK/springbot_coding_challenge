class ChangeLastRecommendedOnRestaurantsUsersTable < ActiveRecord::Migration[5.0]
  def change
    change_column :restaurants_users, :last_recommended, :timestamp
  end
end
