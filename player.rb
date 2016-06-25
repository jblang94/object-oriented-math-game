# Represents a player in the Two Person Math Game
class Player
  attr_reader :name
  attr_accessor :life, :score

  def initialize(name)
    @name = name
    @life = 3
    @score = 0
  end

  # Subtracts 1 from the player's lives
  def update_life
    @life -= 1
  end

  # Adds 1 to the player's score
  def update_score
    @score += 1
  end

  # Returns true if the player is dead, false otherwise
  def dead?
    @life == 0
  end
end