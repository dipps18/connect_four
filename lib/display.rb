module Display

  def prompt_position(name)
    puts "Player #{name}: Enter the column number where you would like to place your marker"
  end

  def prompt_name(player_id)
    puts "Player #{player_id}: Enter your name"
  end

  def display_winner(name)
    puts "Player #{name} wins!"
  end

  def declare_draw
    puts "Draw, all cells filled"
  end
end