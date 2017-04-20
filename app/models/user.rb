class User < ApplicationRecord
  has_many :reviews
  has_many :restaurants_users
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
