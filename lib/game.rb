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
    @player1 = Player.new(get_valid_name(1), "  \u26AA  ")
    @player2 = Player.new(get_valid_name(2), "  \u26AB  ")
    game_loop
  end

  def game_loop
    loop do
      board.display_board
      break if board.gameover? || board.cells_filled == 49

      player  = board.cells_filled % 2 == 0 ? player1 : player2
      position = get_valid_position(player.name)
      board.update_board(position, player.marker)
      board.cells_filled += 1
    end
    name = board.cells_filled % 2 == 0 ? player2.name : player1.name
    board.gameover? ? display_winner(name) : declare_draw
  end

  def get_valid_position(player_id)
    loop do
      prompt_position(player_id)
      position = gets.chomp
      return position.to_i if position.match?(/[0-6]/) && position.length == 1 && board.get_first_empty_row(position.to_i) != 7
    end
  end

  def get_valid_name(player_id)
    loop do
      prompt_name(player_id)
      name = gets.chomp
      return name if name.match?(/\S/)
    end
  end
end