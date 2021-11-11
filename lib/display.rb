module Display

  def prompt_position(player_id)
    puts "#Player {player_id}, please enter the column numbber where you would like to place your marker"
  end

  def prompt_name(player_id)
    puts "#Player {player_id}, please enter your name"
  end


  def display_winner(cells_filled)
    puts cells_filled % 2 == 0 ? "Player 2 wins": "Player 1 wins"
  end
end