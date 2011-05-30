# CPS style
#=================================================================
# Basic style
#------------------------------------------------------------------
def fact(n)
  if n == 0
    1
  else
    n * fact(n-1)
  end
end

"fact(n) => #{fact 5}" # => "fact(n) => 120"

# CPS style
#------------------------------------------------------------------
def fact_cps(n, cnt)
  if n == 0
    cnt.call(1)
  else
    fact_cps(n - 1, lambda {|x|
      cnt.call(n * x)
    })
  end
end

fact_cps 5, lambda {|x| "fact(5) => #{x}" } # => "fact(5) => 120"

lambda {|x| 
  lambda {|x| 
    lambda {|x| 
      lambda {|x| 
        lambda {|x| 
          lambda {|x|
            puts "fact(5) => #{x}" }.
              call(5*x) }.
              call(4*x) }.
              call(3*x) }.
              call(2*x) }.
              call(1*x) }.
              call(1)
# >> fact(5) => 120

