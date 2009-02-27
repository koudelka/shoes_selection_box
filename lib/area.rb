
class Area
  attr_accessor :top_left
  attr_accessor :bottom_right

  def initialize(top_left, bottom_right)
    @top_left = top_left
    @bottom_right = bottom_right
  end

  def intersects?(other_area)
    bottom_right.x
  end

  def to_s
    "#{top_left} -> #{bottom_right}"
  end
end
