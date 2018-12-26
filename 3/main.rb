require 'pry'

arr = Array.new(1000){Array.new(1000){{count: 0, id: nil}}}

ids = Array.new
dups = Array.new

File.open("input", "r") do |f|
  f.each_line do |line|
    id = line[/\d+/].to_i
    offset_left, offset_top = line[/\d+,\d+/].split(",").map(&:to_i)
    width, height = line[/\d+x\d+/].split("x").map(&:to_i)

    ids.push id

    height.times do |y|
      width.times do |x|
        arr[offset_top + y][offset_left + x][:count] += 1
        if arr[offset_top + y][offset_left + x][:id] != nil
          dups.push arr[offset_top + y][offset_left + x][:id]
          dups.push id
        end
        arr[offset_top + y][offset_left + x][:id] = id
      end
    end
  end
end

puts arr.flatten.select{|a| a[:count] > 1}.count

puts (ids - dups.uniq)