def start_loop
  callcc{|c| c }
end

def end_loop(c)
  c.call(c)
end


i = 0

again = start_loop
puts i
i += 1

unless i > 5
  end_loop(again)
end

puts "finish"
# >> 0
# >> 1
# >> 2
# >> 3
# >> 4
# >> 5
# >> finish

