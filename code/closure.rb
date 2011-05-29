# クロージャ
#==================================================================
# counter メソッドは lambda で生成した無名メソッドを返す。
# lambda の中で参照される counte は lambda # 定義の外にある(自由変数)
# counter メソッドは lambda を生成して返す、という役目を終えたが、
# counter によって生成された lambda が counter
# 変数を参照している。counter 変数へは生成された lambda を通してのみ、
# アクセス可能。
def counter(param)
  counter = param
  lambda do |n|
    counter += n
  end
end

counter_start_from99 = counter(99)
counter_start_from99 # => #<Proc:0x00007fb046e2aa60@-:5>
counter_start_from99.call(1) # => 100
counter_start_from99.call(1) # => 101
counter_start_from99.call(1) # => 102

counter_start_from1 = counter(1)
counter_start_from1.call(1) # => 2
counter_start_from1.call(1) # => 3
counter_start_from1.call(1) # => 4

