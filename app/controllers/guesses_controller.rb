class GuessesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @guess = @game.guesses.build(guess_params)

    if @guess.save
      redirect_to game_path(@game)
    else
      @game.guesses.reload # or just remove the guess
      render 'games/show'
    end
  end

  private

  def guess_params
    params.require(:guess).permit(:guess)
  end
end
