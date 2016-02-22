class Game < ActiveRecord::Base
  has_many :guesses
  before_validation :format_word
  validates :word,
  presence: true,
  length: { maximum: 45 },
  format: { with: /\A[A-Z-]+\z/,
    message: "only allows letters and dash" }

  MAX_TRIES = 6

  def running?
    !won? && !lost?
  end

  def won?
    correct_guesses.uniq.length == word.chars.uniq.length
  end

  def lost?
    incorrect_guesses.length >= MAX_TRIES
  end

  def correct_guesses
    p guesses
    correct_guesses = guesses.map(&:guess).select { |g| word.include?(g) }
  end

  def incorrect_guesses
    incorrect_guesses = guesses.map(&:guess).reject { |g| word.include?(g) }
  end

  def format_word
    self.word = self.word.upcase
  end

end
