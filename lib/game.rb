require_relative './display.rb/'

class Game
  include Display
  attr_reader :player1, :player2, :board
  def initialize(player1 = nil, player2 = nil, board = Board.new)
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def play_game
    @player1 = Player.new(get_valid_name(1), "\u26AA")
    @player2 = Player.new(get_valid_name(2), "\u26AB")
    game_loop
    display_winner(board.cells_filled)
  end


  def game_loop
    loop do
      break if board.gameover? || board.cells_filled == 49
      position = get_valid_position((board.cells_filled % 2) + 1)
      board.cells_filled % 2 == 0 ? player1.player_update(position, board) : player2.player_update(position, board)
      board.update_board(position)
      board.cells_filled += 1
    end
  end

  def get_valid_position(player_id)
    loop do
      prompt_position(player_id)
      position = gets.chomp
      position.match?(/[0-6]/) ? break : next
    end
  end

  def get_valid_name(player_id)
    loop do
      prompt_name(player_id)
      name = gets.chomp
      break if name.match?(/\S/)
    end
  end
end