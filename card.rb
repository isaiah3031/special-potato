class Card
  attr_accessor :face_value
  attr_reader :face_down

  def initialize
    @face_value = ""
    @face_down = true
  end

  def hide
    @face_down = true if @face_down == false
  end

  def reveal
    @face_down = false if @face_down == true
  end

  def to_s
    face_value
  end

  def ==(card2)
    face_value == card2.face_value
  end
end
