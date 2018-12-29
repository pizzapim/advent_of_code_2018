require 'pry'

input = File.open('input') {|file| file.readline}

('a'..'z').each do |letter|
  output = input
  temp = ""

  i = 0
  while i != output.length
    if output[i].downcase != letter
      temp += output[i]
    end
    i += 1
  end

  output = temp
  temp = ""

  removed = true

  while removed
    removed = false

    i = 1
    while i < output.length
      if output[i - 1] != output[i] && output[i - 1].downcase == output[i].downcase
        removed = true
        i += 2

        if i == output.length
          temp += output[-1]
        end
      else
        temp += output[i - 1]
        i += 1

        if i == output.length
          temp += output[-1]
        end
      end
    end

    output = temp
    temp = ""
  end

  puts "#{letter}: #{output.length}"
end