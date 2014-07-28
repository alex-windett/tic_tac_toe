class GameController < ApplicationController
 

  def index
    @move = Move.all
    @new_move = Move.new
    if params[:move]
    end
  end
end
