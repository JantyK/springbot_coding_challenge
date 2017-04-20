class HomeController < ApplicationController

  def index
    if user_signed_in?
      @recommendation = Restaurant.joins("LEFT JOIN restaurants_users ON restaurants.id = restaurants_users.restaurant_id")
                                  .where("restaurants_users.user_id = #{current_user.id} OR restaurants_users.user_id IS null")
                                  .where("average_rating > 2 OR average_rating is null")
                                  .order("restaurants_users.last_recommended ASC").first
    else
      @recommendation = Restaurant.joins("LEFT JOIN restaurants_users ON restaurants.id = restaurants_users.restaurant_id")
                                  .where("average_rating > 2 OR average_rating IS null")
                                  .order("RANDOM()").first
    end

    if @recommendation.present? && user_signed_in?
      @review = Review.find_by(restaurant_id: @recommendation.id, user_id: current_user.id)

      @restaurants_user_last_recommended = RestaurantsUser.find_or_initialize_by(user_id: current_user.id, restaurant_id: @recommendation.id)
      @restaurants_user_last_recommended.last_recommended = DateTime.now
      @restaurants_user_last_recommended.save
    end
  end
end
