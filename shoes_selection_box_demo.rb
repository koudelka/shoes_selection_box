#!/usr/bin/env shoes

require 'lib/selection_box'

Shoes.app do
  $app = self
  Shoes.show_log

  selection_box = SelectionBox.new($app.slot, {:fill => gray(0.6, 0.5), :strokewidth => 1})
  objects = []
  25.times do
    objects << rect((0..500).rand,(0..500).rand,50,50)
    objects << oval((0..500).rand, (0..500).rand, 50)
    objects[-1].style({:fill => rgb((0..255).rand, (0..255).rand , (0..255).rand)})
    objects[-2].style({:fill => rgb((0..255).rand, (0..255).rand , (0..255).rand)})
  end

  click do |button, x, y|
    click_point = Point.new(x, y)

    selection_box.start_at(click_point)
  end

  motion do |x, y|
    motion_point = Point.new(x, y)

    selection_box.dragged_to(motion_point)
  end

  release do |button, x, y|
    release_point = Point.new(x, y)

    selection_box.released_at(release_point).each do |obj|
      obj.style({:fill => obj.style[:fill].invert})
    end
  end

end
