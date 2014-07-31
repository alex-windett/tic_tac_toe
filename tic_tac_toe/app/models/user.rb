class User < ActiveRecord::Base
  attr_accessible :dob, :email, :name, :password, :password_confirmation, :picture, :role

  has_many :moves
  has_many :games

  has_secure_password

  validates :name, presence: true
  validates :password_digest, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true, presence: true
  validates :role, presence: true

  def role?(role)
    self.role.to_s == role.to_s
  end

  :password_confirmation

  mount_uploader :picture, PictureUploader
end
