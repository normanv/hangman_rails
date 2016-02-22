class Guess < ActiveRecord::Base
  belongs_to :game
  before_validation :format_guess
  validates :guess,
    presence: true,
    length: { maximum: 1 },
    format: { with: /\A[A-Z-]+\z/,
    message: "only allow a single letter or dash" }

  def format_guess
    self.guess = self.guess.upcase
  end

end
