require "byebug"
require_relative "board"

class ComputerPlayer
  def initialize
    @known_cards = Hash.new { |h, k| h[k] = [] }
    @new_match = []
    @unavailible = []
  end

  def unavailible(guesses)
    guesses.each { |guess| @unavailible << guess }
  end

  def recieve_revealed_card(pos, face_value)
    if is_unknown?(pos)
      @known_cards[face_value] << pos
      matched?(face_value)
    end
  end

  def is_unknown?(pos)
    known_positions = @known_cards.values.flatten(1)
    !known_positions.include?(pos)
  end

  def matched?(face_value)
    known_pos = @known_cards[face_value]
    if known_pos.length == 2 && all_valid?(known_pos)
      @new_match = known_pos
    end
  end

  # Something is wrong with this one
  def pick_match
    first = @new_match
    @new_match = []
    first
  end

  def random_pos
    [rand(4), rand(4)]
  end

  def is_valid?(pos)
    !@unavailible.include?(pos) && !pos.nil?
  end

  def all_valid?(cards)
    cards.all? { |pos| is_valid?(pos) }
  end

  def get_input(board)
    return pick_match if @new_match != []
    pos = random_pos until is_valid?(pos)
    face_value = board[pos].to_s
    recieve_revealed_card(pos, face_value)
    pos
  end
end
