class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates_presence_of :rating, :user_id, :restaurant_id
  validates_uniqueness_of :user_id, scope: :restaurant_id
end
