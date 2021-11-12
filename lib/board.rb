# This class handles board related stuff
class Board
  attr_reader :cells, :create_winning_positions, :WINNING_POSITIONS
  attr_accessor :cells_filled
  def initialize
    @cells_filled = 0
    @cells = Array.new(7){ Array.new(7, "      ") }
    @WINNING_POSITIONS = create_winning_positions
  end

  def create_winning_positions
    horizontal = Array.new(28){ Array.new }
    vertical = Array.new(28){ Array.new }
    diagonal_bottom = Array.new(16){ Array.new }
    diagonal_top = Array.new(16){ Array.new }
    ct = ct_top_diag = ct_bottom_diag = -1 
    (0..6).each do |i|
      (0..3).each do |j|
        ct += 1
        ct_bottom_diag += 1 if i <= 3
        ct_top_diag += 1 if i >= 3
        (0..3).each do |k|
          horizontal[ct].push([i, j + k])
          vertical[ct].push([j + k, i])
          diagonal_top[ct_top_diag].push([i - k, j + k]) if i >= 3
          diagonal_bottom[ct_bottom_diag].push([i + k, j + k]) if i <= 3
        end
      end
    end
    [horizontal, vertical, diagonal_bottom, diagonal_top].flatten(1)
  end


  def display_board
    puts "    0      1      2      3      4      5      6"
    (0..6).each do |i|
      puts "+------+------+------+------+------+------+------+"
      (0..6).each { |j| print "|#{cells[j][6 - i]}" }
      print"|\n"
    end
    puts "+------+------+------+------+------+------+------+"
  end

  def update_board(column, marker)
    row = get_first_empty_row(column)
    @cells[column][row] = marker
  end

  def gameover?
    @WINNING_POSITIONS.any? do |position|
      board_elements = [@cells[position[0][0]][position[0][1]], @cells[position[1][0]][position[1][1]], @cells[position[2][0]][position[2][1]], @cells[position[3][0]][position[3][1]]]
      board_elements.uniq.count == 1 && !board_elements.include?("      ")
    end
  end

  def get_first_empty_row(column)
    @cells[column].count{ |x| x != "      " }
  end
  
end

