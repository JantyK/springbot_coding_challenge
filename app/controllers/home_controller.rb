class HomeController < ApplicationController

  def index
    @recommendation = Restaurant.order("RANDOM()").first

    if user_signed_in?
      @review = Review.find_by(restaurant_id: @recommendation.id, user_id: current_user.id)
    end
  end
end
