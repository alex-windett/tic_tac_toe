class GamesController < ApplicationController
 
  def index
    @move = Move.all
    @new_move = Move.new
    @game = Game.all

     # @game = Game.create

  #   if params[:themove]
  #     @game.moves.create(square_id:params[:themove])
  #   end
  end


  def show
    @game = Game.find(params[:id])
    @move = @game.moves
    
    if params[:player_move]
      @game.moves.create(square_id: params[:player_move])
    end
  end

def new 
 @game = Game.new
 @user = User.all

# redirect_to @game

 # (params[:game])
  

  # respond_to do |format|
  #     if @game.save
  #       format.html { redirect_to @game, notice: 'Start Playing a new game.' }
  #       format.json { render json: @game, status: :created, location: @game }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @game.errors, status: :unprocessable_entity }
  #     end
  #   end
end

def create
  @game = Game.new(params[:game])
  

  respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Start Playing a new game.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end

end

def destroy
  @game = Game.find(params[:id])
  @game.destroy

  respond_to do |format|
      format.html { redirect_to games_path }
      format.json { head :no_content }
    end
end

end
