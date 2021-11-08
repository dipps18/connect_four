require_relative '../lib/board.rb'

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
end