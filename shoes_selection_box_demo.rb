#!/usr/bin/env shoes

require 'lib/selection_box'

Shoes.app do
  $app = self
  Shoes.show_log

  selection_box = SelectionBox.new($app, {:fill => gray(0.6, 0.5), :strokewidth => 1})
  objects = []
  25.times do
    objects << rect((0..500).rand,(0..500).rand,50,50)
    objects << oval((0..500).rand, (0..500).rand, 50)
    objects[-1].style({:fill => rgb((0..255).rand, (0..255).rand , (0..255).rand)})
    objects[-2].style({:fill => rgb((0..255).rand, (0..255).rand , (0..255).rand)})
  end

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

    selected_area = selection_box.released_at(release_point)
    objects.each do |obj|
      if obj.intersects?(selected_area)
        obj.style({:fill => obj.style[:fill].invert})
      end
    end
  end

end
