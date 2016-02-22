class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @guess = Guess.new(game: @game)
  end

  def destroy
  @game = Game.find(params[:id])
  @game.destroy
  redirect_to games_path
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game
    else
      render 'new'
    end
  end

  private

  def game_params
    params.require(:game).permit(:word)
  end
end
