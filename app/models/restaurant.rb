class Restaurant < ApplicationRecord
  has_many :reviews
  has_many :restaurants_users

  validates_presence_of :name
end
