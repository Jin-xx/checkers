# encoding: UTF-8
require './checkerpieces.rb'
require 'colored'

class Board

  attr_accessor :board, :white_pieces, :black_pieces, :all_pieces, :displayed_board

  WHITE_INITIAL_POSITIONS = []
  BLACK_INITIAL_POSITIONS = []


  def initialize

    create_initial_positions
    @white_pieces = []
    @black_pieces = []
    create_initial_pieces
    @all_pieces = @white_pieces + @black_pieces
    @displayed_board = []
    create_board
    place_pieces
    display_board

  end


  def create_initial_positions
    (0..2).each do |x|
      (0..7).each do |y|
        if x + y < 10 && (x + y) % 2 == 1
          WHITE_INITIAL_POSITIONS << [x,y]
        end
      end
    end

    (5..7).each do |x|
      (0..7).each do |y|
        if (5..49) === (x + y) && (x + y) % 2 == 1
          BLACK_INITIAL_POSITIONS << [x,y]
        end
      end
    end
  end

  # WHITE_INITIAL_POSITIONS = [[3,4]]
  # BLACK_INITIAL_POSITIONS = [[4,3],[6,1]]


  def create_initial_pieces
    WHITE_INITIAL_POSITIONS.each do |position|
      @white_pieces << CheckerPiece.new(self, position, :white)
    end
    BLACK_INITIAL_POSITIONS.each do |position|
      @black_pieces << CheckerPiece.new(self, position, :black)
    end
  end

  def create_board
    @displayed_board = []
    4.times do
      i = 0
      row = []
      8.times do
        row << "   ".black_on_white unless i % 2 == 0
        row << "   ".red_on_black if i % 2 == 0
        i += 1
      end
      @displayed_board << row
      @displayed_board << row.dup.reverse
    end
  end

  def display_board
    puts "   0  1  2  3  4  5  6  7"

    @displayed_board.each_with_index do |row, index|
      print index
      print ' '
      puts row.join("")
    end
    return
  end

  def place_pieces
    create_board
    @white_pieces.each do |piece|
      if !piece.king
        @displayed_board[piece.position[0]][piece.position[1]] = " \u26C0 ".black_on_white
      else
        @displayed_board[piece.position[0]][piece.position[1]] = " \u26C1 ".black_on_white
      end
    end
    @black_pieces.each do |piece|
      if !piece.king
        @displayed_board[piece.position[0]][piece.position[1]] = " \u26C2 ".black_on_white
      else
        @displayed_board[piece.position[0]][piece.position[1]] = " \u26C3 ".black_on_white
      end
    end

  end

  def piece_at_location(location, color)
    #make an all pieces array
    if color == :white
      white_pieces.select{|piece| piece.position == location}[0]
    elsif color == :black
      black_pieces.select{|piece| piece.position == location}[0]
    end
  end

  def opposite_color

    if @color == :white
      return :black
    elsif @color == :black
      return :white
    end

  end

  def all_positions
    all_locations = []
    all_pieces.each do |piece|
      all_locations << piece.position
    end
    all_locations
  end

  def make_kings
    @all_pieces.each do |piece|
      piece.check_if_king
    end
  end




end