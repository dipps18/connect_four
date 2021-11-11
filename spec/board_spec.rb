require_relative '../lib/board.rb'
require_relative '../lib/player.rb'

describe Board do
  describe '#initialize' do
    subject(:board_winning_pos) { described_class.new }
    it 'should contain [[0, 0], [0, 1], [0, 2], [0, 3]]' do
      array = [[0, 0], [0, 1], [0, 2], [0, 3]]
      expect( board_winning_pos.WINNING_POSITIONS.any?{|position| array.intersection(position) == array }).to be(true)
    end

    it 'should contain [[0, 0], [1, 0], [2, 0], [3, 0]]' do
      array = [[0,0],[1,0],[2,0],[3,0]]
      expect( board_winning_pos.WINNING_POSITIONS.any?{|position| array.intersection(position) == array }).to be(true)
    end

    it 'should contain [[0, 1], [1, 2], [2, 3], [3, 4]]' do
      array = [[0,1],[1,2],[2,3],[3,4]]
      expect( board_winning_pos.WINNING_POSITIONS.any?{|position| array.intersection(position) == array }).to be(true)
    end

    it 'should contain [[0, 6], [1, 5], [2, 4], [3, 3]]' do
      array = [[0,6],[1,5],[2,4],[3,3]]
      expect( board_winning_pos.WINNING_POSITIONS.any?{|position| array.intersection(position) == array }).to be(true)
    end

    it 'should contain [[0, 0], [0, 3], [0, 2], [0, 1]]' do
      array = [[0,0],[0,3],[0,2],[0,1]]
      expect( board_winning_pos.WINNING_POSITIONS.any?{|position| array.intersection(position) == array }).to be(true)
    end

    it 'should not contain [[0, 0], [2, 0], [4, 0], [6, 0]]' do
      array = [[0, 0], [2, 0], [4, 0], [6,0]]
      expect( board_winning_pos.WINNING_POSITIONS.any?{|position| array.intersection(position) == array }).to be(false)
    end

    it 'should not contain [[1, 0], [3, 0], [5, 0], [4, 0]]' do
      array = [[1, 0], [3, 0], [5, 0], [4, 0]]
      expect( board_winning_pos.WINNING_POSITIONS.any?{|position| array.intersection(position) == array }).to be(false)
    end

    it 'should not contain [[0 ,6], [1, 5], [3, 3], [3, 2]]' do
      array = [[0 ,6], [1, 5], [3, 3], [3, 2]]
      expect( board_winning_pos.WINNING_POSITIONS.any?{|position| array.intersection(position) == array }).to be(false)
    end

    it 'should not contain [[0, 0], [2, 2], [4, 4], [5, 5]]' do
      array = [[0, 0], [2, 2], [4, 4], [5, 5]]
      expect( board_winning_pos.WINNING_POSITIONS.any?{|position| array.intersection(position) == array }).to be(false)
    end

    it 'should have not have only position with length = 4' do
      expect(board_winning_pos.WINNING_POSITIONS.any?{ |position| position.length != 4 }).to be(false)
    end

    it 'should have coordinates between (0, 6)' do
      expect(board_winning_pos.WINNING_POSITIONS.flatten.all?{ |element| element.between?(0, 6)}).to be(true)
    end
  end

  describe '#update_board' do
    subject(:board_update) { described_class.new }

    context 'When board is empty' do

      it 'should add player marker to [0, 0] in board cell when position is 0' do
        player_marker = "\u26AA"
        board_update.update_board(0, player_update)
        expect(board_update.cells[0][0]).to eq (player_marker)
      end

      it 'should add player marker to [6, 0] in board cell when position is 6' do
        player_marker = "\u26AA"
        board_update.update_board(6, player_update)
        expect(board_update.cells[6][0]).to eq (player_marker)
      end
    end

    context 'When board is not empty' do
      subject(:board_update) { described_class.new }
      let(:player_update) { Player.new('dipps', "\u26AB") }
 
      it 'should add player marker to [0, 1] in board cell when position is 0 and [0, 0] is filled' do
        player_marker = "\u26AB"
        board_update.cells[0][0] = player_marker
        board_update.update_board(0, player_update)
        expect(board_update.cells[0][1]).to eq (player_marker)
      end

      it 'should add player marker to [1, 2] in board cell when position is 1 and [1, 1] is filled' do
        player_marker = "\u26AB"
        board_update.cells[1][0] = "\u26AA"
        board_update.cells[1][1] = player_marker
        board_update.update_board(1, player_update)
        expect(board_update.cells[1][2]).to eq (player_marker)
      end

      it 'shouldn\'t add player marker when column is filled' do
        board_update.cells[1] = ["\u26AA", "\u26AA", "\u26AB", "\u26AB", "\u26AA", "\u26AA", "\u26AB"]
        player_marker = "\u26AA"
        board_update.update_board(1, player_update)
        expect(board_update.cells[1][6]).not_to eq (player_marker)
      end
      
      it 'should return nil when column is full' do
        board_update.cells[1] = ["\u26AA", "\u26AA", "\u26AB", "\u26AB", "\u26AA", "\u26AA", "\u26AB"]
        expect(board_update.update_board(1, player_update)).to eq(nil)
      end
    end
  end

  describe '#gameover?' do
  let(:board_gameover) { described_class.new }
    context 'When 4 consecutive markers are present horizontally' do
      it 'should return true' do
        player_marker = "\u26AA" 
        board_gameover.cells[0][0] = board_gameover.cells[0][1] = board_gameover.cells[0][2] = board_gameover.cells[0][3] = player_marker
        board_gameover.display_board
        expect(board_gameover.gameover?).to be(true)
      end
    end

    context 'When 4 consecutive markers are present vertically' do
      it 'should return true' do
        player_marker = "\u26AA" 
        board_gameover.cells[6] = [" ", "\u26AA", "\u26AA", "\u26AA"]
        board_gameover.cells[0][0] = board_gameover.cells[1][0] = board_gameover.cells[2][0] = board_gameover.cells[3][0] = player_marker
        board_gameover.display_board
        expect(board_gameover.gameover?).to be(true)
      end
    end

    context 'When 4 consecutive markers are present diagonally from the bottom' do
      it 'should return true' do
        player_marker = "\u26AA" 
        board_gameover.cells[0][3] = board_gameover.cells[1][4] = board_gameover.cells[2][5] = board_gameover.cells[3][6] = player_marker
        board_gameover.display_board
        expect(board_gameover.gameover?).to be(true)
      end
    end

    context 'When 4 consecutive marker are present diagonally from the top' do
      it 'should return true' do
        player_marker = "\u26AB"
        board_gameover.cells[6] = [" ", "\u26AA", "\u26AA", "\u26AA"]
        board_gameover.cells[6][0] = board_gameover.cells[5][1] = board_gameover.cells[4][2] = board_gameover.cells[3][3] = player_marker
        board_gameover.display_board
        expect(board_gameover.gameover?).to be(true)
      end
    end

    context 'When no 4 consecutive markers are present' do
      it 'should return false' do
        player_marker = "\u26AB"
        board_gameover.cells[4][3] = "\u26AA"
        board_gameover.cells[6][0] = board_gameover.cells[5][1] = board_gameover.cells[3][3] = player_marker
        board_gameover.display_board
        expect(board_gameover.gameover?).to be(false)
      end
    end
  end
end