require './checkerplayer.rb'
require './checkerboard.rb'

class Game
  attr_accessor :board

  def initialize

    @board = Board.new
    @white_player = Player.new
    @black_player = Player.new
    @game_over = false

  end

  # def make_move(start_position, end_location)
  #   piece = @board.piece_at_location(start_position)
  #   p piece.slide_move
  #   begin
  #     if piece.slide_move.include?(end_location)
  #       piece.perform_slide(end_location)
  #     elsif piece.jump_move.include?(end_location)
  #       piece.perform_jump(end_location)
  #     end
  #   rescue InvalidMoveError => e
  #     puts e
  #   end
  # end

  def make_move(position_array)
    board = @board.dup
    begin
      piece = board.piece_at_location(position_array[0])
      piece.perform_moves(position_array[1])
      # board.all_pieces.each do |piece|
      #   piece.board = board
      # end
    rescue InvalidMoveError => e
      puts e
    end
    @board = board
  end

  def move_array(long_position_array)
    new_board = @board.dup
    until long_position_array.length == 1
      begin
        new_board = make_move([long_position_array.shift, long_position_array[0]])
      rescue InvalidMoveError => e
        puts e
        puts "Invalid position at #{position_array[0]}"
      end
    end
  end

end