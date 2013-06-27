class CheckerPieces

  attr_accessor: location

	def initialize(position)
    @position = position
    king = false
  end

  def available_moves
    #returns available moves in an array
  end

  def next_move?(location)
    #boolean on weather next move is available 
    # or use available_moves.include?
  end

  def slide_move

  end

  def jump_move

  end

  def perform_moves

  end



end
