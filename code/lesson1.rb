
# Proc と lambda
#=================================================================
RUBY_VERSION # => "1.8.7"
# Proc.new は引数チェックがユルい
Proc.new { |a,b| [a,b] }.call(1,2,3)  rescue $!.class # => [1, 2]
lambda   { |a,b| a     }.call(1)      rescue $!.class # => ArgumentError
lambda   { |a,b| [a,b] }.call(1,2)    rescue $!.class # => [1, 2]

# return した時、どこまで戻るか？が違う。
#----------------------------------------------------------------
def meth(&block)
  block.call
end

proc_obj = Proc.new { return 99 }
lambda_obj = lambda { return 99 }
meth(&proc_obj)   rescue $!.class # => LocalJumpError
meth(&lambda_obj) rescue $!.class # => 99

# Phrase: break は値を返すことができる。
#------------------------------------------------------------------
def show_break
  puts "before yield"
  yield
  puts "after yield" # これは呼ばれない。
end

result = show_break do
  puts "before break"
  break 123 # !> statement not reached
  puts "after break" # これも呼ばれない。
end
result # => 123

# >> before yield
# >> before break
#

#
