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

  def play
    current_player = @black_player

    until @game_over
      current_player = (current_player == @white_player) ? @black_player : @white_player
      current_player_color = (current_player == @white_player) ? :white : :black
      turn(current_player, current_player_color)
    end

  end

  def turn(current_player, color)
    begin
      input_move_array = current_player.get_move
      move_array(input_move_array, color)
      @board.make_kings
      @board.place_pieces
      @board.display_board
      if @board.white_pieces.length == 0
        @game_over = true
        puts "Black Wins!"
      elsif @board.black_pieces.length == 0
        @game_over = true
        puts "White Wins!"
      end
    rescue
      puts "Try again"
      turn(current_player, color)
    end

  end

  def make_move(position_array, color)
    board = @board.dup
    begin
      piece = board.piece_at_location(position_array[0], color)
      piece.perform_moves(position_array[1])
    rescue InvalidMoveError => e
      puts e
    end
    board.all_pieces = board.white_pieces + board.black_pieces
    @board = board
  end

  def move_array(long_position_array, color)
    new_board = @board.dup
    until long_position_array.length == 1
      begin
        new_board = make_move([long_position_array.shift, long_position_array[0]], color)
      rescue InvalidMoveError => e
        puts e
        puts "Invalid position at #{position_array[0]}"
      end
    end
    new_board.white_pieces.each do |piece|
      piece.board = new_board
    end
    new_board.black_pieces.each do |piece|
      piece.board = new_board
    end
  end

end