class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_restaurant, only: [:show, :create, :update]
  before_action :find_review, only: [:update]

  def create
    update_last_visited = params[:reviews][:last_visited]
    if update_last_visited.present?
      @last_visited = RestaurantsUser.find_by(user_id: current_user.id, restaurant_id: @restaurant.id)
      if @last_visited.nil?
        @last_visited = RestaurantsUser.create(create_restaurants_user_params)
      else
        @last_visited.update(last_visited: update_last_visited)
      end
    end

    @review = Review.create(create_review_params)
    if @review.errors.present?
      flash[:alert] = 'Error! Please try again!'
      redirect_to restaurant_path(@restaurant)
    else
      flash[:notice] = 'Success! New review created!'
      redirect_to restaurant_path(@restaurant)
    end
  end

  def update
    update_last_visited = params[:reviews][:last_visited]
    if update_last_visited.present?
      @last_visited = RestaurantsUser.find_by(user_id: current_user.id, restaurant_id: @restaurant.id)
      if @last_visited.nil?
        @last_visited = RestaurantsUser.create(create_restaurants_user_params)
      else
        @last_visited.update(last_visited: update_last_visited)
      end
    end

    @review.update(update_review_params)
    if @review.errors.present?
      flash[:alert] = 'Error! Please try again!'
      redirect_to restaurant_path(@restaurant)
    else
      flash[:notice] = 'Successfully updated your review!'
      redirect_to restaurant_path(@restaurant)
    end
  end

  private

  def create_review_params
    params.require(:reviews).permit(
      :body,
      :restaurant_id,
      :user_id,
      :rating
    )
  end

  def create_restaurants_user_params
    params.require(:reviews).permit(
      :restaurant_id,
      :user_id,
      :last_visited
    )
  end

  def update_review_params
    params.require(:reviews).permit(
      :body,
      :rating,
      :restaurant_id
    )
  end

  def find_restaurant
    @restaurant = Restaurant.find_by_id(params[:reviews][:restaurant_id])
  end

  def find_review
    @review = Review.find_by_id(params[:id])
  end
end
