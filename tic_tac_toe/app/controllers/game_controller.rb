class GameController < ApplicationController
 

  def index
    @move = Move.all
    @new_move = Move.new
    @game = Game.all

    # @game = Game.create

    if params[:player_move]
      @game.moves.create(square_id:params[:player_move])
    end
  end


  def show
    @game = Game.find(params[:id])
    @move = @game.moves
    
    if params[:player_move]
      @game.moves.create(square_id: params[:player_move])
    end
  end
end
