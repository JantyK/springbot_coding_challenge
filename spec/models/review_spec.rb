require 'rails_helper'

  RSpec.describe Review, type: :model do
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:restaurant_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_inclusion_of(:rating).in_range(1..5) }
    it { should_not allow_value(0).for(:rating) }
    it { should_not allow_value(6).for(:rating) }

    it "calculates the average rating for the restaurant and updates the restaurant" do
      @user_one = User.create(email: "user_one@gmail.com", password: "123456")
      @user_two = User.create(email: "user_two@gmail.com", password: "123456")
      @restaurant = Restaurant.create(name: "Wendy's")
      @review = Review.create(user_id: @user_one.id, restaurant_id: @restaurant.id, rating: 5)
      @restaurant.reload
      expect(@restaurant.average_rating).to eq(5.0)
      @review = Review.create(user_id: @user_two.id, restaurant_id: @restaurant.id, rating: 2)
      @restaurant.reload
      expect(@restaurant.average_rating).to eq(3.5)
      @review.update(rating: 3)
      @restaurant.reload
      expect(@restaurant.average_rating).to eq(4.0)
    end
end
