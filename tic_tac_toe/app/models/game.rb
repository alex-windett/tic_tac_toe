class Game < ActiveRecord::Base
  attr_accessible :user_id, :winner_id, :square_id

  belongs_to :user
  has_many :moves
end
