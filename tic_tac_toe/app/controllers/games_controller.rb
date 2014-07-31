class GamesController < ApplicationController
 
  before_filter :authenticate

  def index
    @move = Move.all
    @new_move = Move.new
    @game = Game.all
  end


  def show
    @game = Game.find(params[:id])
    @games = Game.all
    @moves = @game.moves
    @user = User.all
    @users_moves = []
    @comps_moves = []
    @player_2 = []
    @move = Move.all
    winning_line = [ 
        [1,2,3], [4,5,6], [7,8,9], 
        [1,4,7], [2,5,8], [3,6,9], 
        [1,5,9], [3,5,7] 
      ]


    @user.each do |user|
      @user_name = user.name
    end
    
    if params[:player_move]

      if @moves.last
          if @moves.last.player_id
            @moves.create(square_id: params[:player_move])
          else 
            @moves.create(square_id: params[:player_move], player_id: 1)
          end
      else
           @moves.create(square_id: params[:player_move], player_id: 1)
      end
     

        @all_moves = @game.moves.map do 
          |move| move.square_id.to_i
        end

        availiable_moves = [*1..9]    

        @all_moves.each do |move|
          availiable_moves.delete(move)
        end 

        if @game.player2_id == "Computer" 
          comp_move = availiable_moves.sample
        
          @game.moves.create(square_id: comp_move)
        end

        @users_moves = @game.moves.where(player_id: 1).map do |move| move.square_id.to_i
        end

        # @player_2 = @game.moves.where(player2_id: 1).map do |move| move.square_id.to_i
        # end

        @comps_moves = @game.moves.where(player_id: nil).map do |move| move.square_id.to_i
        end

        winning_line.each do |line|
          case
            when line & @users_moves == line 
            @message = "#{current_user.name} Wins !"
            @game.winner_id = current_user.id
            # @game.user_id
            @game.save
             
            when line & @comps_moves  == line 
            @message = "Player 2 Wins !"
            @game.winner_id = @game.player2_id
            @game.save
            
          end
          
        end
      end
    end

def new 
 @game = Game.new
 @user = User.all
 @cuser = @current_user
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
