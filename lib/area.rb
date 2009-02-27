class Area
  attr_accessor :top_left
  attr_accessor :bottom_right

  def initialize(top_left, bottom_right)
    @top_left = top_left
    @bottom_right = bottom_right
  end

  def intersects?(other_area)
    top = top_left.y
    bottom = bottom_right.y
    right = bottom_right.x
    left = top_left.x
    other_top    = other_area.top_left.y
    other_bottom = other_area.bottom_right.y
    other_right  = other_area.bottom_right.x
    other_left   = other_area.top_left.x

    bottom > other_top and
    top < other_bottom and
    right > other_left and
    left < other_right
  end

  def to_s
    "#{top_left} -> #{bottom_right}"
  end
end
