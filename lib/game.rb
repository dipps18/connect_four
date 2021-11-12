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
    if board.gameover?
      board.cells_filled % 2 == 0 ? display_winner(player2.name) : display_winner(player1.name)
    else
      declare_draw
    end
  end


  def game_loop
    loop do
      board.display_board
      break if board.gameover? || board.cells_filled == 49
      if board.cells_filled % 2 == 0 
        position = get_valid_position(player1.name)
        player1.player_update(position, board)
        board.update_board(position, player1.marker)
      else
        position = get_valid_position(player2.name)
        player2.player_update(position, board)
        board.update_board(position, player2.marker)
      end
      board.cells_filled += 1
    end
  end

  def get_valid_position(player_id)
    loop do
      prompt_position(player_id)
      position = gets.chomp
      position.match?(/[0-6]/) ? (return position.to_i) : next
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