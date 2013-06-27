class CheckerPiece

  attr_accessor :position, :king, :color

	def initialize(board, position, color)
    @position = position
    @king = false
    @color = color
    @board = board
  end


  def slide_move
    w_slide = [[1,-1],[1,1]]
    b_slide = [[-1,-1],[-1,1]]
    k_slide = w_slide + b_slide
    move = []
    if @king && !self.nil?
      k_slide.each do |slide|
        temp_move = [slide[0] + @position[0], slide[1] + @position[1]]
        move << temp_move if in_board?(temp_move) && empty?(temp_move)
      end
    elsif @color == :white && !king && !self.nil?
      w_slide.each do |slide|
        temp_move = [slide[0] + @position[0], slide[1] + @position[1]]
        move << temp_move if in_board?(temp_move) && empty?(temp_move)
      end
    end
    if @color == :black && !king &&!self.nil?
      b_slide.each do |slide|
        temp_move = [slide[0] + @position[0], slide[1] + @position[1]]
        move << temp_move if in_board?(temp_move) && empty?(temp_move)
      end
    end
    move
  end

  def jump_move
    move = []
    w_jump = [[2,-2],[2,2]]
    b_jump = [[-2,-2],[-2,2]]
    k_jump = w_jump + b_jump
    w_take = [[1,-1],[1,1]]
    b_take = [[-1,-1],[-1,1]]
    k_take = w_take + b_take
    if @king && !self.nil?
      k_jump.each_with_index do |jump, index|
        temp_move = [jump[0] + @position[0], jump[1] + @position[1]]
        kill_piece = [k_take[index][0] + @position[0], k_take[index][1] + @position[1]]
        move << temp_move if in_board?(temp_move) && empty?(temp_move) && !piece_at_location(kill_piece).nil? && piece_at_location(kill_piece).color == :black
      end
    elsif @color == :white && !self.nil? && !@king
      w_jump.each_with_index do |jump, index|
        temp_move = [jump[0] + @position[0], jump[1] + @position[1]]
        kill_piece = [w_take[index][0] + @position[0], w_take[index][1] + @position[1]]
        move << temp_move if in_board?(temp_move) && empty?(temp_move) && !piece_at_location(kill_piece).nil? && piece_at_location(kill_piece).color == :black
      end
    elsif @color == :black && !self.nil? && !@king
      b_jump.each_with_index do |jump, index|
        temp_move = [jump[0] + @position[0], jump[1] + @position[1]]
        kill_piece = [b_take[index][0] + @position[0], b_take[index][1] + @position[1]]
        move << temp_move if in_board?(temp_move) && empty?(temp_move) && !piece_at_location(kill_piece).nil? && piece_at_location(kill_piece).color == :white
      end
    end
    move
  end

  def perform_slide(location)
    @position = location
  end

  def perform_jump(location)
    kill_piece_location = [(@position[0] + location[0])/2, (@position[1] + location[1])/2]
    @board.white_pieces.delete_if{|piece| piece.position == kill_piece_location}
    @board.black_pieces.delete_if{|piece| piece.position == kill_piece_location}
    @position = location
  end

  def perform_moves(location)
    if jump_move.include?(location)
      perform_jump(location)
    elsif slide_move.include?(location)
      perform_slide(location)
    else
      raise InvalidMoveError.new "Not a valid move"
    end
  end


  def in_board?(location)

    (0..7).include?(location[0]) && (0..7).include?(location[1])

  end

  def make_king
    @king = true
  end

  def empty?(location)
    #make an all pieces array
    @board.all_pieces.select{|piece| piece.position == location}.empty?
  end

  def piece_at_location(location)
    #make an all pieces array
    @board.all_pieces.select{|piece| piece.position == location}[0]
  end

  def check_if_king
    if @color == :white
      if @position[0] == 7
        make_king
      end
    elsif @color == :black
      if @position[0] == 0
        make_king
      end
    end
  end
end

class InvalidMoveError < StandardError

end
