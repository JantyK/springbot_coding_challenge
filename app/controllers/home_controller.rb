class HomeController < ApplicationController

  def index
    @recommendation = Restaurant.order("RANDOM()").first
  end
end
