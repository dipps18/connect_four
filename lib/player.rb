class Player
  attr_reader :name, :marker
  attr_accessor :position
  def initialize(name, marker)
    @name = name
    @marker = marker
    @position = []
  end
end