class User < ActiveRecord::Base
  attr_accessible :dob, :email, :name, :password_digest, :picture, :role

  has_many :moves
  has_many :games

  validates :name, presence: true
  validates :password_digest, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true
  validates :role, presence: true

  mount_uploader :picture, PictureUploader
end
