require_relative "board"
require_relative "card"
require_relative "humanplayer"
require_relative "computerplayer"
require "byebug"

class Game
  def initialize
    @board = Board.new
    @board.populate
    @human_player = HumanPlayer.new
    @computer_player = ComputerPlayer.new
  end

  def guesses_to_cards(guesses)
    pair1, pair2 = guesses
    card1, card2 = @board[pair1], @board[pair2]
    [card1.to_s, card2.to_s]
  end

  def match?(guesses)
    card1, card2 = guesses_to_cards(guesses)
    pos1, pos2 = guesses
    card1.to_s == card2.to_s && pos1 != pos2
  end

  def is_unavailible(guesses)
    @computer_player.unavailible(guesses)
  end

  def hide_guesses(guesses)
    guesses.each do |pos|
      @board[pos].hide
    end
  end

  def inform_computer(new_pos, face)
    face = @board[new_pos].to_s
    @computer_player.recieve_revealed_card(new_pos, face)
  end

  def switch_players(players)
    players.rotate!
  end

  # The issues are coming from here. Find a way to take in one or two values from get input
  def player_input(current_player)
    guesses = []
    until guesses.length == 2
      pos = current_player.get_input(@board)
      pos[0].is_a?(Integer) ? guesses << pos : guesses = pos
    end
    guesses.each { |guess| reveal_guesses(guess) }
    guesses
  end

  def reveal_guesses(pos)
    face_value = @board[pos].reveal
    inform_computer(pos, face_value)
    @board.render
    sleep(1)
  end

  def play
    players = @computer_player, @human_player
    until @board.won?
      @board.render
      current_player = players.first
      guesses = player_input(current_player)
      match?(guesses) ? is_unavailible(guesses) : hide_guesses(guesses)
      switch_players(players)
    end
  end
end
