require 'lib/shoes_shared/shoes_shared'

class SelectionBox
  attr_accessor :click_point
  attr_accessor :rectangle
  attr_accessor :slot
  attr_accessor :styles

  def initialize(slot, styles)
    @slot = slot
    @styles = styles
  end

  def start_at(point)
    @click_point = point
    rectangle.remove if !rectangle.nil? # protects from dragging outside window and releasing
    @rectangle = slot.rect(@click_point.x, @click_point.y, 0, 0)
    rectangle.style(styles)
  end

  def dragged_to(point)
    return if click_point.nil?
    new_left = (click_point.x <= point.x ? click_point.x : point.x)
    new_top  = (click_point.y <= point.y ? click_point.y : point.y)

    new_width  = (click_point.x - point.x).abs
    new_height = (click_point.y - point.y).abs

    rectangle.move(new_left, new_top)
    rectangle.width = new_width
    rectangle.height = new_height

    selected_objects(coverage)
  end

  def released_at(point)
    [] if @click_point.nil?
    area = coverage

    rectangle.remove
    @rectangle = nil #hopefully Shoes will let it get GC'd
    @click_point = nil

    selected_objects(area)
  end

  def coverage
    Area.new(Point.new(left, top), Point.new(left+width, top+height))
  end

  def selected_objects(area)
    slot.contents.collect do |obj|
      next if obj.nil? or !obj.is_a?(Shoes::Shape) or obj == rectangle

      obj if obj.intersects?(area)
    end.compact
  end


  def to_s
    coverage.to_s
  end

  def method_missing(method, *args)
    rectangle.send(method, *args)
  end

end
