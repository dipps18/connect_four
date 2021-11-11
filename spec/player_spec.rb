require_relative '../lib/player.rb'
require_relative '../lib/board.rb'

describe Player do
  describe '#update_player' do
    subject(:player_update) { described_class.new('dipps', "\u26AA")}
    context 'When column is available' do
      subject(:board) { instance_double( Board )}
      before do
        column = 3
        allow(board).to receive(:get_first_empty_row).and_return(2)
      end

      it 'should update player position when player is empty and only 2 positions are filled in column 3' do
        column = 3
        expect(player_update.position).to receive(:push).with([3,2])
        player_update.player_update(column, board)
      end
    end

    context 'When column is full' do
      subject(:board) { instance_double( Board )}
      before do
        column = 3
        allow(board).to receive(:get_first_empty_row).and_return(7)
      end
    end

  end
end