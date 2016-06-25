require_relative './game'

puts "Begin new math game? Type \"yes\" or \"no\""
response = gets.chomp
game = Game.new
game.create_players

until response == 'no'
  puts ""
  game.run
  puts ""
  puts "Play again? \"yes\" or \"no\""
  response = gets.chomp
  if response == 'yes'
    game.reset_scores
    game.reset_lives
  else
    puts "Quitting math game"
    puts ""
  end
end