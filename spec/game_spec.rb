require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
require_relative '../lib/board.rb'

describe Game do
  describe '#game_loop' do
    context 'When gameover is false and then true' do
      subject(:game) { described_class.new(instance_double(Player, name:"dipps", marker: "\u26AA"), instance_double(Player, name: "sums", marker: "\u26AB")) }
      before do
        allow(game.player1).to receive(:player_update)
        allow(game.board).to receive(:update_board).and_return(nil)
        allow(game.player2).to receive(:player_update)
        allow(game.board).to receive(:gameover?).and_return(false, true)
	    end

      it 'should loop once' do
        expect(game).to receive(:get_valid_position).once
        game.game_loop
      end

      it 'should receive update_player once' do
        expect(game.player1).to receive(:player_update).once
        game.game_loop
      end

      it 'should update cells_filled by 1' do
        game.board.cells_filled = 0
        expect{ game.game_loop }.to change{ game.board.cells_filled }.by(1) 
      end 
    end

    context 'When position is invalid, invalid and then valid' do
      subject(:game) { described_class.new(instance_double(Player, name:"dipps", marker: "\u26AA"), instance_double(Player, name: "sums", marker: "\u26AB")) }
      before do
        allow(game.player1).to receive(:player_update)
        allow(game.board).to receive(:update_board).and_return(nil)
        allow(game.player2).to receive(:player_update)
        allow(game.board).to receive(:gameover?).and_return(false, false, true)
	    end

      it 'should loop twice' do
        expect(game).to receive(:get_valid_position).twice
        game.game_loop
      end

      it 'should receive update_player once each' do
        expect(game.player1).to receive(:player_update).once
        expect(game.player2).to receive(:player_update).once
        game.game_loop
      end

      it 'should update cells_filled by 1' do
        game.board.cells_filled = 0
        expect{ game.game_loop }.to change{ game.board.cells_filled }.by(2) 
      end 
    end

    context 'When position is valid' do
      subject(:game) { described_class.new(instance_double(Player, name:"dipps", marker: "\u26AA"), instance_double(Player, name: "sums", marker: "\u26AB")) }
      before do
        allow(game.player1).to receive(:player_update)
        allow(game.board).to receive(:update_board).and_return(nil)
        allow(game.player2).to receive(:player_update)
        allow(game.board).to receive(:gameover?).and_return(false, true)
	    end

      it 'should loop once' do
        expect(game).to receive(:get_valid_position).once
        game.game_loop
      end

      it 'should receive update_player once' do
        expect(game.player1).to receive(:player_update).once
        game.game_loop
      end

      it 'should update cells_filled by 1' do
        game.board.cells_filled = 0
        expect{ game.game_loop }.to change{ game.board.cells_filled }.by(1) 
      end 
    end

    context 'When position is valid' do
      subject(:game) { described_class.new(instance_double(Player, name:"dipps", marker: "\u26AA"), instance_double(Player, name: "sums", marker: "\u26AB")) }
      before do
        allow(game.player1).to receive(:player_update)
        allow(game.board).to receive(:update_board).and_return(nil)
        allow(game.player2).to receive(:player_update)
        allow(game.board).to receive(:gameover?).and_return(true)
	    end

      it 'shouldn\'t loop' do
        expect(game).not_to receive(:get_valid_position)
        game.game_loop
      end

      it 'should not receive update_player' do
        expect(game.player1).not_to receive(:player_update)
        game.game_loop
      end

      it 'shouldn\'t update cells_filled' do
        game.board.cells_filled = 0
        expect{ game.game_loop }.not_to change{ game.board.cells_filled } 
      end 
    end
  end

  describe '#get_valid_position' do
    subject(:game) { described_class.new }
    context 'When position is valid' do
      before do
        allow(game).to receive(:prompt_position)
        allow(game).to receive(:gets).and_return('1')
      end
      it 'should receive gets only once' do
        player_id = 1
        expect(game).to receive(:gets).once
        game.get_valid_position(player_id)
      end
    end
    
    context 'When position is invalid and then valid' do
      before do
        allow(game).to receive(:gets).and_return('a', '6')
      end
      it 'should receive gets twice' do
        player_id = 2
        expect(game).to receive(:gets).twice
        game.get_valid_position(player_id)
      end
      
    end

    context 'When position is invalid, invalid and then valid' do
      subject(:game) { described_class.new }
      context 'When position is valid' do
        before do
          allow(game).to receive(:gets).and_return('a' , '-', '0')
        end
        it 'should receive gets only thrice' do
          player_id = 1
          expect(game).to receive(:gets).thrice
          game.get_valid_position(player_id)
        end
      end
    end
  end

  describe '#get_valid_name' do
    subject(:game) { described_class.new }
    context 'When name is invalid and then valid' do
      before do
        allow(game).to receive(:prompt_name)
        allow(game).to receive(:gets).and_return(' ', 'dipps')
      end
      it 'should receive gets twice' do
        player_id = 1
        expect(game).to receive(:gets).twice
        game.get_valid_name(player_id)
      end
    end

    context 'When name is invalid, invalid and then valid' do
      before do
        allow(game).to receive(:prompt_name)
        allow(game).to receive(:gets).and_return(' ', ' ', 'sumz12')
      end
      it 'should receive gets twice' do
        player_id = 2
        expect(game).to receive(:gets).thrice
        game.get_valid_name(player_id)
      end
    end

    context 'When name is valid' do
      before do
        allow(game).to receive(:prompt_name)
        allow(game).to receive(:gets).and_return('sumz12')
      end
      it 'should receive gets twice' do
        player_id = 2
        expect(game).to receive(:gets).once
        game.get_valid_name(player_id)
      end
    end
  end

  describe '#display_winner' do
    subject(:game) { described_class.new }
    context 'When player 1 wins' do


      it 'should display player 1 as the winner' do
        cells_filled = 9
        message = "Player 1 wins"
        expect(game).to receive(:puts).with(message)
        game.display_winner(cells_filled)
      end
    end

    context 'When player 2 wins' do
      it 'should display player 2 as the winner' do
        cells_filled = 8
        message = "Player 2 wins"
        expect(game).to receive(:puts).with(message)
        game.display_winner(cells_filled)
      end
    end
  end
end 