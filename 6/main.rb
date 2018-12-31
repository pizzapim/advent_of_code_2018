require 'pry'

coords = []

# Parse input file.

File.open("input", "r") do |f|
  f.each_line do |line|
    x, y = line.split(", ").map(&:chomp).map(&:to_i)
    coords.push({
      x: x,
      y: y,
    })
  end
end

# Create matrix with correct size

left_bound = right_bound = coords.first[:x]
top_bound = bottom_bound = coords.first[:y]

coords.each do |coord|
  if coord[:x] < left_bound
    left_bound = coord[:x]
  end

  if coord[:x] > right_bound
    right_bound = coord[:x]
  end

  if coord[:y] < top_bound
    top_bound = coord[:y]
  end

  if coord[:y] > bottom_bound
    bottom_bound = coord[:y]
  end
end

height = bottom_bound - top_bound + 1
width = right_bound - left_bound + 1

coords.map!{|coord| {x: coord[:x] - left_bound, y: coord[:y] - top_bound}}

matrix = Array.new(height){Array.new(width){0}}

# Fill the matrix with lowest distance to coordinates

(0...height).each do |y|
  (0...width).each do |x|
    coords.each_with_index do |coord, i|
      distance = (x - coord[:x]).abs + (y - coord[:y]).abs

      matrix[y][x] += distance
    end
  end
end

=begin
# Count the area for each coordinate.

(0...height).each do |y|
  (0...width).each do |x|
    if (y == 0 || x == 0 || y == height - 1 || x == width - 1) && matrix[y][x][:coords].length == 1
      coords[matrix[y][x][:coords].first][:infinite] = true
    else
      if matrix[y][x][:coords].length == 1
        coords[matrix[y][x][:coords].first][:area] += 1
      end
    end
  end
end
=end

puts matrix.flatten.select{|point| point < 10000}.length