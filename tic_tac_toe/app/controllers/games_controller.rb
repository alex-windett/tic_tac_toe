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
    @moves = @game.moves # all the moves for a single game
    @user = User.all
    @users_moves = [] # saving users' moves
    @comps_moves = [] # saving computer's moves
    @player_2 = []  # saving player 2's moves
    @move = Move.all
    winning_line = [ 
        [1,2,3], [4,5,6], [7,8,9], 
        [1,4,7], [2,5,8], [3,6,9], 
        [1,5,9], [3,5,7] 
      ]
    # All the possible wining combinations in a 9x9 grid


    @user.each do |user|
      @user_name = user.name
    end
    
    if params[:player_move]

      if @moves.last
          if @moves.last.player_id
            @moves.create(square_id: params[:player_move])
              # if there was a previus move and the previous move
              # was made by a player create save the players    
              # move to that square
          else 
            @moves.create(square_id: params[:player_move], player_id: 1)
              # otherwise create a save a player id of 1 to
              # that square
          end
      else
           @moves.create(square_id: params[:player_move], player_id: 1)
            # if no player has yet to move, save the first move
            # and square id with player id 1
      end



        @all_moves = @game.moves.map do 
          |move| move.square_id.to_i
        end
        # finding all moves for a perticular game

        availiable_moves = [*1..9] 
        # all available squares for a 9x9 game  

        @all_moves.each do |move|
          availiable_moves.delete(move)
        end 
        # itterate over all moves played, and delete from       
        # the available moves

        if @game.player2_id == "Computer" 
          comp_move = availiable_moves.sample
        
          @game.moves.create(square_id: comp_move)
        end
        # if the player 2 has been selected to be a computer
        # chose a random number from the availble moves
        # save the square id with computor move

        @users_moves = @game.moves.where(player_id: 1).map do |move| 
          move.square_id.to_i
        end
        # finding each of the users moves for a perticular game

        @comps_moves = @game.moves.where(player_id: nil).map do |move| move.square_id.to_i
        end
        # finding all the computors moves for a perticular game

        winning_line.each do |line|
          case
            when line & @users_moves == line 
            @message = "#{current_user.name} Wins !"
            @game.winner_id = current_user.id
            
            @game.save
             
            when line & @comps_moves  == line 
            @message = "Player 2 Wins !"
            @game.winner_id = @game.player2_id
            @game.save
            
          end
          # finding the winners
          # when a winning lines matches those save in a computors
          # or players move, output a corosponding message
          
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
