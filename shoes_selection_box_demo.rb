#!/usr/bin/env shoes

require 'lib/selection_box'

Shoes.app do
  $app = self
  Shoes.show_log

  selection_box = SelectionBox.new($app, {:fill => gray(0.6, 0.5), :strokewidth => 1})
  r = rect(200,200,50,50)

  making_selection_box = false

  click do |button, x, y|
    click_point = Point.new(x, y)

    making_selection_box = true

    selection_box.start_at(click_point)
  end

  motion do |x, y|
    motion_point = Point.new(x, y)

    selection_box.dragged_to(motion_point) if making_selection_box
  end

  release do |button, x, y|
    release_point = Point.new(x, y)

    making_selection_box = false

    debug selection_box.released_at(release_point)
  end

end
