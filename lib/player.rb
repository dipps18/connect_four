class Player
  attr_reader :name, :marker
  attr_accessor :position
  def initialize(name, marker)
    @name = name
    @marker = marker
    @position = []
  end

  def player_update(column, board)
    row = board.get_first_empty_row(column)
    @position.push([column, row])
  end
end