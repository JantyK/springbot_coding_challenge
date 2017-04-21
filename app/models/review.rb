class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates_presence_of :rating, :user_id, :restaurant_id
  validates_uniqueness_of :user_id, scope: :restaurant_id
  validates :rating, inclusion: 1..5

  after_create :update_restaurant_average_rating
  after_update :update_restaurant_average_rating

  private

  def update_restaurant_average_rating
    @restaurant = Restaurant.find_by(id: self.restaurant_id)
    average_rating = @restaurant.reviews.sum(:rating)/@restaurant.reviews.count.to_f
    @restaurant.update(average_rating: average_rating)
    
  end
end
