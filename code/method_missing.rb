require 'pp'

class CommandListener
  def initialize
    @commands = []
  end
    
  def method_missing(*args)
    args  # !> useless use of a variable in void context
    @commands << args
    self
  end
end

listener = CommandListener.new

listener.instance_eval do
  this object accepts whatever you and stores it
end
listener
 # => #<CommandListener:0x7f54e518c158
 #     @commands=
 #      [[:you],
 #       [:whatever, #<CommandListener:0x7f54e518c158 ...>],
 #       [:accepts, #<CommandListener:0x7f54e518c158 ...>],
 #       [:object, #<CommandListener:0x7f54e518c158 ...>],
 #       [:this, #<CommandListener:0x7f54e518c158 ...>],
 #       [:it],
 #       [:stores, #<CommandListener:0x7f54e518c158 ...>]]>

listener = CommandListener.new
listener.instance_eval do
  this.object.accepts.whatever.commands.and.stores.it
end  

listener
# => #<CommandListener:0x7f54e5184408
#     @commands=
#      [[:this],
#       [:object],
#       [:accepts],
#       [:whatever],
#       [:commands],
#       [:and],
#       [:stores],
#       [:it]]>

require 'pp'

class BlankSlate
  instance_methods.each do |method|
    undef_method(method) unless method =~ /^__/ || method == 'instance_eval'
   end
end

class CommandListener2 < BlankSlate
  def initialize
    @commands = []
  end

  def method_missing(*args)
    @commands << args unless [:inspect, :to_s].include? args.first 
    self
  end
  
  def to_str
    @commands.inspect
  end
end
listener = CommandListener2.new
listener.instance_eval do
  you can even type freeze!
end
listener
 # => [:type, #<CommandListener2:0x7f54e517c2d0>], [:even, #<CommandListener2:0x7f54e517c2d0>], [:can, #<CommandListener2:0x7f54e517c2d0>], [:you, #<CommandListener2:0x7f54e517c2d0>], [:class], [:respond_to?, :to_str]] 

