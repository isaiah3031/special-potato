require_relative "game"

class HumanPlayer
  def get_input(board)
    puts "Enter a coordinate."
    chosen_pos
  end

  def chosen_pos
    row, col = gets.chomp.split(" ")
    [row.to_i, col.to_i]
  end
end
