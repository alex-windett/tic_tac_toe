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
    @games = Game.all
    @moves = @game.moves
    @user = User.all
    @user_moves_array = []
    @comp_moves_array = []
    @move = Move.all
    @winning_combination = [1, 2, 3]

    @move.each do |move|
      @user_move = move.player_id
    end

    @user.each do |user|
      @user_name = user.name
    end
  
    if params[:player_move]
      @moves.create(square_id: params[:player_move], player_id: 2)

        @user_moves_array = @game.moves.map do |move| move.square_id.to_i
        end

        availiable_moves = [*1..9]    

            @user_moves_array.each do |move_id|
              availiable_moves.delete(move_id)
            end 
            @comp_moves_array.each do |move_id|
              availiable_moves.delete(move_id)
            end   

        comp_move = availiable_moves.sample
      @game.moves.create(square_id: comp_move)

      @comp_moves_array = @game.moves.map {|move| move.square_id.to_i}
    end

   


  end

def new 
 @game = Game.new
 @user = User.all
end

def create
  @game = Game.new(params[:game])
  @user = User.all
  

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
