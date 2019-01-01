require 'pry'

orders = []
instructions = []

# Parse input file.

File.open("input", "r") do |f|
  f.each_line do |line|
    first, second = line.scan(/\s[A-Z]{1}\s/).map(&:strip)
    orders.push({
      first: first,
      then: second
    })
    instructions.push(first)
    instructions.push(second)
  end
end

instructions.uniq!

result = ""

workers = 5.times.map do
  {
    current_instruction: nil,
    time_left: 0
  }
end

time = 0

while !instructions.empty?
  # Get a list of the next instructions available.
  next_instructions = instructions.select do |instruction|
    orders.none? do |order|
      order[:then] == instruction && order[:first] != nil
    end and workers.none? do |worker|
      worker[:current_instruction] == instruction
    end
  end.sort

  # Give free workers instructions.
  workers.each_with_index do |worker, i|
    if worker[:current_instruction].nil? and !next_instructions.empty?
      workers[i][:current_instruction] = next_instructions[0]
      workers[i][:time_left] = next_instructions[0].ord - "A".ord + 1 + 60
      next_instructions.delete(next_instructions[0])
    end
  end

  elapsed_time = workers.select do |worker|
    !worker[:current_instruction].nil?
  end.map do |worker|
    worker[:time_left]
  end.min

  time += elapsed_time

  workers.each_with_index do |worker, i|
    if !workers[i][:current_instruction].nil?
      workers[i][:time_left] -= elapsed_time

      if workers[i][:time_left] == 0
        instructions.delete(workers[i][:current_instruction])
        orders.each do |order|
          if order[:first] == workers[i][:current_instruction]
            order[:first] = nil
          end
        end

        workers[i][:current_instruction] = nil
      end
    end
  end

  #binding.pry
end

=begin

while !instructions.empty?
  next_instruction = instructions.select do |instruction|
    orders.none? do |order|
      order[:then] == instruction && order[:first] != nil
    end
  end.sort.first

  result += next_instruction

  instructions.delete next_instruction
  orders.each do |order|
    if order[:first] == next_instruction
      order[:first] = nil
    end
  end
end

=end

puts time