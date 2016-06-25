require 'colorize'
require_relative './player'
# Provides the interface and logic for the Two Person Math Game
class Game

  # Creates the two players for the game
  def create_players
    name = ""
    puts "Enter Player 1's name: "
    name = gets.chomp
    @player_1 = (name.empty?) ? Player.new("Player 1") : Player.new(name)
    puts "Enter Player 2's name: "
    name = gets.chomp
    @player_2 = (name.empty?) ? Player.new("Player 2") : Player.new(name)
  end

  # Reset the players' scores to 0
  def reset_scores
    @player_1.score = 0
    @player_2.score = 0
  end

  # Reset the players' lives to 3
  def reset_lives
    @player_1.life = 3
    @player_2.life = 3
  end

  # Runs the game
  def run
    puts "*** TWO PLAYER MATH GAME ***"
     @player_1_turn = true
    until @player_1.dead? || @player_2.dead?
      generate_question_and_answer
      puts @question
      @player_answer = gets.chomp.to_i
      if player_correct?
        update_score
      else 
        update_life
        show_lives
      end
      @player_1_turn = (@player_1_turn) ? false : true  
    end
    puts ""
    show_winner
    show_scores
  end

  private

  attr_accessor :player_1_turn, :question, :answer, :player_1, :player_2, :player_answer
  OPERATIONS = {
    add: "+",
    subtract: "-",
    multiply: "*"
  }

  # Creates a question and its answer
  def generate_question_and_answer
    first_num = rand(1..20)
    second_num = rand(1..20)
    operation = OPERATIONS.keys.sample
    @question = ((@player_1_turn) ? @player_1.name : @player_2.name) + ": What does #{first_num} #{OPERATIONS[operation]} #{second_num} equal?"
    @answer = calculate_answer(first_num, second_num, operation)
  end

  # Calculates the correct answer to the question
  def calculate_answer(first_num, second_num, operation)
    case OPERATIONS[operation]
    when OPERATIONS[:add]
      @answer = first_num + second_num
    when OPERATIONS[:subtract]
      @answer = first_num - second_num
    when OPERATIONS[:multiply]
      @answer = first_num * second_num
    end
  end

  # Returns true if the player's answer is correct, false otherwise
  def player_correct?
    @player_answer == @answer
  end

  # Updates the current player's score
  def update_score
    (@player_1_turn) ? @player_1.update_score : @player_2.update_score
  end

  # Updates the current player's life
  def update_life
    (@player_1_turn) ? @player_1.update_life : @player_2.update_life
  end

  # Show the players' lives
  def show_lives
    player_1_lives =  "#{@player_1.name}\'s Life: #{@player_1.life}"
    player_2_lives =  "#{@player_2.name}\'s Life: #{@player_2.life}"
    if @player_1_turn
      player_1_lives = player_1_lives.red
    else
      player_2_lives = player_2_lives.red
    end
    puts ""
    puts player_1_lives
    puts player_2_lives
    puts ""
  end

  # Show the player's scores
  def show_scores
    puts ""
    puts "#{@player_1.name}\'s Score: #{@player_1.score}"
    puts "#{@player_2.name}\'s Score: #{@player_2.score}"
    puts ""
  end

  # Show the winner of the game
  def show_winner
    winner = ((@player_1.dead?) ? "#{@player_2.name.upcase}" : "#{@player_1.name.upcase}") + " IS THE WINNER!"
    puts winner.green.bold
  end
end