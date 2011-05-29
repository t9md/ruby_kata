str = ""
class << str
  self  # => #<Class:#<String:0x7ff527870b80>>
  def speak
    "miaow"
  end
end

str.speak # => "miaow"
class T9md
  class << self
    def do_something
      "something"
    end
  end
  do_something # => "something"
end

class Person < Struct.new(:name, :age)
  def greet
      puts "Hello #{self.name}"
  end
end

f = Person.new("Chad", 28)
f # => #<struct Person name="Chad", age=28>

