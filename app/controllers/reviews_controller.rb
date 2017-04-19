class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_restaurant
  before_action :find_review, only: [:update]
  before_action :find_or_create_restaurants_user, only: [:update, :create]

  def create
    if params[:reviews][:rating].present?
      @review = Review.create(create_review_params)
      if @review.errors.blank?
        flash[:notice] = 'Success! New review created!'
        redirect_to restaurant_path(@restaurant)
      else
        flash[:alert] = 'Error! Unable to create your review!'
        redirect_to restaurant_path(@restaurant)
      end
    end
  end

  def update
    @review.update(update_review_params)
    if @review.errors.empty?
      flash[:notice] = 'Successfully updated your review!'
      redirect_to restaurant_path(@restaurant)
    else
      flash[:alert] = 'Error! Please try again!'
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

  def update_review_params
    params.require(:reviews).permit(
      :body,
      :rating,
      :restaurant_id
    )
  end

  def find_restaurant
    @restaurant = Restaurant.find_by(id: params[:reviews][:restaurant_id])
  end

  def find_review
    @review = Review.find_by(id: params[:id])
  end

  def find_or_create_restaurants_user
    update_last_visited = params[:reviews][:last_visited]
    if !update_last_visited.blank?
      @last_visited = RestaurantsUser.find_or_create_by(user_id: current_user.id, restaurant_id: @restaurant.id)
      @last_visited.update(last_visited: update_last_visited)

      if @last_visited.errors.blank?
        flash[:notice] = 'Success! Updated the last time you visited!'
        if params[:reviews][:rating].blank?
          redirect_to restaurant_path(@restaurant)
        end
      else
        flash[:alert] = 'Error! Unable to update the last time you visited!'
        redirect_to restaurant_path(@restaurant)
      end
    end
  end
end
