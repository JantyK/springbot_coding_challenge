class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show]
  before_action :find_restaurant, only: [:show]

  def index
    @restaurants = Restaurant.all
  end

  def create
    @restaurant = Restaurant.create(create_restaurant_params)

    if @restaurant.errors.present?
      flash[:alert] = 'Error! Please try again!'
      render :new
    else
      flash[:notice] = 'Success! New Restaurant Created!'
      redirect_to restaurant_path(@restaurant)
    end
  end

  def new
  end

  def show
    @last_visited = RestaurantsUser.find_or_initialize_by(user_id: current_user.id, restaurant_id: @restaurant.id)
    @review = Review.find_or_initialize_by(user_id: current_user.id, restaurant_id: @restaurant.id)
  end

  private

  def create_restaurant_params
    params.require(:restaurant).permit(
      :name
    )
  end

  def find_restaurant
    @restaurant = Restaurant.find_by(id: params[:id])
  end
end
