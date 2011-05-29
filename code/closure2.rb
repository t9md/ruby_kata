def counter(start=0, increment=1)
  start -= increment
  lambda do
    start += increment
  end
end
cnt_fr0_inc2 = counter(0,2)
cnt_fr0_inc2.call # => 0
cnt_fr0_inc2.call # => 2
cnt_fr0_inc2.call # => 4

cnt_fr10_inc3 = counter(10, 3)
cnt_fr10_inc3.call # => 10
cnt_fr10_inc3.call # => 13
cnt_fr10_inc3.call # => 16
