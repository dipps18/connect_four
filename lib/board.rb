class Board
  attr_reader :cells, :WINNING_POSITIONS
  def initialize
    @cells = Array.new(7){ Array.new(7, " ")}
    @WINNING_POSITIONS = create_winning_positions
    display_board
  end

  def create_winning_positions
    horizontal = []
    vertical = []
    diagonal_bottom = []
    diagonal_top = []
    ct = ct_top_diag = ct_bottom_diag = -1 
    (0..6).each do |i|
      (0..3).each do |j|
        ct += 1
        horizontal[ct] = Array.new
        vertical[ct] = Array.new
        diagonal_bottom[ct_bottom_diag += 1] = Array.new if i <= 3
        diagonal_top[ct_top_diag += 1] = Array.new if i >= 3
        (0..3).each do |k|
          horizontal[ct].push([i, j + k])
          vertical[ct].push([j + k, i])
          diagonal_top[ct_top_diag].push([i - k, j + k]) if i >= 3
          diagonal_bottom[ct_bottom_diag].push([i + k, j + k]) if i <=3
        end
      end
    end
     [horizontal, vertical, diagonal_bottom, diagonal_top].flatten(1)
  end

  def display_board
    puts "   0     1     2     3     4     5     6"
    (0..6).each do |i|
      puts "+-----+-----+-----+-----+-----+-----+-----+"
      (0..6).each do |j|
      print "|  #{cells[6 - i][j]}  "
      end
      print"|\n"
    end
    puts "+-----+-----+-----+-----+-----+-----+-----+"
  end
end