class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates_presence_of :rating, :user_id, :restaurant_id
end
