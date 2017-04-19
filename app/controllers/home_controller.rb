class HomeController < ApplicationController

  def index
    @recommendation = Restaurant.order("RANDOM()").first

    if @recommendation.present? && user_signed_in?
      @review = Review.find_by(restaurant_id: @recommendation.id, user_id: current_user.id)

      @last_recommended = RestaurantsUser.find_or_create_by(user_id: current_user.id, restaurant_id: @recommendation.id)
      @last_recommended.update(last_recommended: DateTime.now)
    end
  end
end
