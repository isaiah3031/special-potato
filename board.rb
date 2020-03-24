require_relative "card"
require "byebug"

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(4) { Array.new(4) { Card.new } }
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def set_face_value(card, deck)
    card.face_value = deck[0]
    deck.shift
  end

  def populate
    deck = new_deck
    @grid.each do |row|
      row.each { |card| set_face_value(card, deck) }
    end
  end

  def possible_faces
    ("A".."Z").to_a
  end

  def place_card(faces, deck)
    deck << faces.sample
    faces.delete(deck[-1])
  end

  def double_deck(deck)
    deck.shuffle + deck.shuffle
  end

  def new_deck
    deck = []
    faces = possible_faces
    8.times { place_card(faces, deck) }
    double_deck(deck)
  end

  def hide_or_display(card)
    card.face_down ? "  " : "#{card.face_value} "
  end

  def render
    system("clear")
    @grid.each do |row|
      row.each do |card|
        print hide_or_display(card)
      end
      puts
    end
    puts "-" * 8
  end

  def won?
    @grid.all? do |row|
      row.all? { |card| !card.face_down }
    end
  end
end
