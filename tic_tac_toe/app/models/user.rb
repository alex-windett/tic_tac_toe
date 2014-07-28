class User < ActiveRecord::Base
  attr_accessible :dob, :email, :name, :password_digest, :picture, :role

  has_many :moves
  has_many :games
end
