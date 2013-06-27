class Game


  def find_piece_at_location(color, location)

    get_pieces_of_color(color).select(|piece| piece.location == location)

  end

  def get_pieces_of_color(color)

    if color == :red
      return @red_pieces
    else
      return @white_pieces
    end

  end


  def delete_at_location(color, location)
    get_pieces_of_color(color).delete_if{ |piece| piece.location == location}
  end

  
  
end