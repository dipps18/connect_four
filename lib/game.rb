class Game
  attr_reader :player1, :player2, :board
  def initialize(board = nil, player1 = nil, player2 = nil)
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def game_loop
    loop do
      break if board.gameover? || board.cells_filled == 49
      board.cells_filled
      position = get_valid_position((board.cells_filled % 2) + 1)
      board.cells_filled % 2 == 0 ? player1.player_update(position, board) : player2.player_update(position, board)
      board.cells_filled += 1
    end
  end

  def get_valid_position(player_id)
  end
end