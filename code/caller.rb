def foo(num)
  caller(num)
end

def bar(num)
  foo(num)
end

bar(0) # => ["-:2:in `foo'", "-:6:in `bar'", "-:9"]
bar(1) # => ["-:6:in `bar'", "-:10"]
bar(2) # => ["-:11"]
bar(3) # => []


def parse_caller(at)
  if /^(.+?):(\d+)(?::in `(.*)')?/ =~ at
    file = $1
    line = $2.to_i
    method = $3
    [file, line, method]
  end
end

def meth1
  caller[0] # => "-:30:in `meth2'"
  p parse_caller(caller.first)
end

def meth2
  meth1
  # parse_caller(caller.first)
end

