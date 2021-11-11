require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
require_relative '../lib/board.rb'

describe Game do
  describe '#game_loop' do
    context 'When gameover is false and then true' do
      subject(:game) { described_class.new(instance_double(Board), instance_double(Player, name:"dipps", marker: "\u26AA"), instance_double(Player, name: "sums", marker: "\u26AB")) }
      before do
        allow(board).to receive(:cells_filled).and_return(0)
        allow(game.player1).to receive(:player_update)
        allow(game.board).to receive(:cells_filled=)
        allow(game.board).to receive(:gameover?).and_return(false, true)
        allow(game.board).to receive(:display_board)
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
        expect{ game.game_loop }.to change{ game.board.cells_filled }.from(0).to(1) 
      end
    end
  end
end 