class Player

  def get_move
    begin
      user_input = take_input
    rescue Exception
      #REV: this exception could be more informative (minor...)
      puts "Invalid input: try again."
      get_move
    end
  end

  def take_input
    puts "Select starting position to ending position or positions ex: 2,0 3,0 or 2,0 3,0 4,0 5,0"
    all_pos_array = []
    #REV: variable naming here is a bit confusing 
    all_pos = gets.chomp.split(" ")
    all_pos.each do |pos|
      all_pos_array << pos.split(",").map{ |j| Integer(j)}
    end
    all_pos_array
  end

end
