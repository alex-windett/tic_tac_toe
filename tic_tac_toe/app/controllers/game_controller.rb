class GameController < ApplicationController

  def index
    @move = Move.all
  end

end
