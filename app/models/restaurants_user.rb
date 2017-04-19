class RestaurantsUser < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates_presence_of :user_id, :restaurant_id
end
