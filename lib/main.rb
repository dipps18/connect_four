require_relative 'board.rb'
require_relative 'display.rb'
require_relative 'game.rb'
require_relative 'player.rb'

loop do
  game = Game.new()
  game.play_game
  puts "Press 'y' to play again or any key to quit"
  ans = gets.chomp
  break unless ans == 'y'
end

puts "Goodbye"