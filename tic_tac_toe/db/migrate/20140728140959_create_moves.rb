class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.integer :player_id
      t.integer :game_id
      t.string :square_id

      t.timestamps
    end
  end
end
