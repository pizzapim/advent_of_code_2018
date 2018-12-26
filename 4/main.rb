require 'pry'

events = []

guards = {}

File.open("input", "r") do |f|
  f.each_line do |line|
    events.push ({
      date: line[/\d{4}-\d{2}-\d{2} \d{2}:\d{2}/],
      type: (line.end_with?("shift\n") ? :begins_shift : (line.end_with?("asleep\n") ? :falls_asleep : :wakes_up)),
      id: line[/#\d+/].to_s[1..-1].to_i
    })
  end
end

events.sort_by! do |event|
  event[:date]
end

current_guard = 0
begin_minute = 0

events.each do |event|
  if event[:type] == :begins_shift
    if guards[event[:id]].nil?
      guards[event[:id]] = Array.new(60){0}
    end

    current_guard = event[:id]
  elsif event[:type] == :falls_asleep
    begin_minute = event[:date][-2..-1].to_i
  else
    (event[:date][-2..-1].to_i - begin_minute).times do |minute|
      guards[current_guard][begin_minute + minute] += 1
    end
  end
end

# Strategy 1

sleepiest_guard = 0
longest_time = 0

guards.each do |id, counts|
  time = counts.inject(:+)
  if time > longest_time
    longest_time = time
    sleepiest_guard = id
  end
end

sleepiest_minute = 0
max_count = 0

guards[sleepiest_guard].each_with_index do |count, index|
  if count > max_count
    max_count = count
    sleepiest_minute = index
  end
end

puts sleepiest_minute * sleepiest_guard

# Strategy 2

guard = 0
minute = 0
count = 0

guards.each do |id, counts|
  max_count = 0
  max_index = 0
  counts.each_with_index do |count_, index|
    if count_ > max_count
      max_count = count_
      max_index = index
    end
  end

  if max_count > count
    guard = id
    minute = max_index
    count = max_count
  end
end

puts guard * minute