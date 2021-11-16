require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
require_relative '../lib/board.rb'

describe Game do
  describe '#game_loop' do
    context 'When gameover is false but all cells are filled' do
      subject(:game) { described_class.new(instance_double(Player, name:"dipps", marker: "\u26AA"), instance_double(Player, name: "sums", marker: "\u26AB")) }
      before do
        game.board.cells_filled = 49
        allow(game.board).to receive(:update_board).and_return(nil)
        allow(game.board).to receive(:gameover?).and_return(false)
      end

      it 'should not loop' do
        expect(game).not_to receive(:gets)
        game.game_loop
      end

      it 'should declare draw' do
        expect(game).to receive(:declare_draw)
        game.game_loop
      end
    end

    context 'When gameover is false and then true' do
      subject(:game) { described_class.new(instance_double(Player, name:"dipps", marker: "\u26AA"), instance_double(Player, name: "sums", marker: "\u26AB")) }
      before do
        allow(game).to receive(:get_valid_position).and_return(0)
        allow(game.board).to receive(:update_board).and_return(nil)
        allow(game.board).to receive(:gameover?).and_return(false, true)
	    end

      it 'should loop once' do
        expect(game).to receive(:get_valid_position).once
        game.game_loop
      end

      it 'should display name of player 1 as winner when cells_filled are odd' do
        game.board.cells_filled = 6
        name = 'dipps'
        expect(game).to receive(:display_winner).with(name)
        game.game_loop
      end

      it 'should display name of player 2 as winner when cells_filled are even' do
        game.board.cells_filled = 5
        name = 'sums'
        expect(game).to receive(:display_winner).with(name)
        game.game_loop
      end

      it 'should update cells_filled by 1' do
        game.board.cells_filled = 0
        expect{ game.game_loop }.to change{ game.board.cells_filled }.by(1) 
      end 
    end

    context 'When gameover is false, false and then true' do
      subject(:game) { described_class.new(instance_double(Player, name:"dipps", marker: "\u26AA"), instance_double(Player, name: "sums", marker: "\u26AB")) }
      before do
        allow(game).to receive(:get_valid_position).and_return(0)
        allow(game.board).to receive(:update_board).and_return(nil)
        allow(game.board).to receive(:gameover?).and_return(false, false, true)
	    end

      it 'should loop twice' do
        expect(game).to receive(:get_valid_position).twice
        game.game_loop
      end

      it 'should update cells_filled by 1' do
        game.board.cells_filled = 0
        expect{ game.game_loop }.to change{ game.board.cells_filled }.by(2) 
      end
    end

    context 'When gameover is false then true' do
      subject(:game) { described_class.new(instance_double(Player, name:"dipps", marker: "\u26AA"), instance_double(Player, name: "sums", marker: "\u26AB")) }
      before do
        allow(game).to receive(:get_valid_position).and_return(0)
        allow(game.board).to receive(:update_board).and_return(nil)
        allow(game.board).to receive(:gameover?).and_return(false, true)
	    end

      it 'should loop once' do
        expect(game).to receive(:get_valid_position).once
        game.game_loop
      end

      it 'should update cells_filled by 1' do
        game.board.cells_filled = 0
        expect{ game.game_loop }.to change{ game.board.cells_filled }.by(1) 
      end 
    end

    context 'When gameover is true' do
      subject(:game) { described_class.new(instance_double(Player, name:"dipps", marker: "\u26AA"), instance_double(Player, name: "sums", marker: "\u26AB")) }
      before do
        allow(game.board).to receive(:update_board).and_return(nil)
        allow(game.board).to receive(:gameover?).and_return(true)
	    end

      it 'shouldn\'t loop' do
        expect(game).not_to receive(:get_valid_position)
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

      it 'should receive gets twice when position is filled' do
        allow(game).to receive(:gets).and_return('5', '6')
        player1_marker = "  \u26AA  "
        player2_marker = "  \u26AB  "
        game.board.cells[5] = [player1_marker, player1_marker, player1_marker, player2_marker, player2_marker, player2_marker, player1_marker]
        player_id = 2
        expect(game).to receive(:gets).twice
        game.get_valid_position(player_id)
      end

      it 'should receive gets twice' do
        allow(game).to receive(:gets).and_return('a', '6')
        player_id = 2
        expect(game).to receive(:gets).twice
        game.get_valid_position(player_id)
      end
      
    end

    context 'When position is invalid, invalid and then valid' do
      context 'When position is valid' do
        before do
          allow(game).to receive(:gets).and_return('55' , '-', '0')
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
end 
