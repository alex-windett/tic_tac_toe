class Move < ActiveRecord::Base
  attr_accessible :game_id, :player_id, :player2_id, :square_id

  belongs_to :user
  belongs_to :game
end
