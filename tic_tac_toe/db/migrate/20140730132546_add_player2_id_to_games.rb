class AddPlayer2IdToGames < ActiveRecord::Migration
  def change
    add_column :games, :player2_id, :string
  end
end
