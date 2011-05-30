# CPS style
#=================================================================
class Split
  def initialize(app) @app = app end
  def call(data)
    data = data.split
    @app.call(data)
  end
end
class Upcase
  def initialize(app) @app = app end
  def call(data)
    data = data.map(&:upcase)
    @app.call(data)
  end
end
class Eliminate
  def initialize(app)
    @app = app
    @words = %w(badword drug)
  end
  def call(data)
    data.map! do |e|
      if @words.include? e
        "*" * e.size
      else
        e
      end
    end
    @app.call(data)
  end
end
class Join
  def initialize(app) @app = app end
  def call(data)
    @app.call(data.join("\n"))
  end
end

class App
  def initialize
    puts "App start"
  end
  def call(env)
    env
  end
end

class Builder
  def initialize(string, &blk)
    @string = string
    instance_eval(&blk)
  end
  def result
    @result
  end
  @@apps = []
  def run(klass)
    @@apps.unshift klass
  end
  def to_app(initial_app)
    @@apps.inject(initial_app) do |app, middleware|
      app = middleware.new(app)
      app
    end
  end
  def finish
    app = to_app App.new
    @result = app.call(@string)
  end
end
string =<<'EOS'
this is the sentence
for testing CPS style
programming , 
splitted , eliminated badword and like drug
and then upcased
finally joined with "\n"
EOS
ret = Builder.new(string) do
  run Split
  run Eliminate
  run Upcase
  run Join
  finish
end
puts ret.result # => nil
# >> App start
# >> THIS
# >> IS
# >> THE
# >> SENTENCE
# >> FOR
# >> TESTING
# >> CPS
# >> STYLE
# >> PROGRAMMING
# >> ,
# >> SPLITTED
# >> ,
# >> ELIMINATED
# >> *******
# >> AND
# >> LIKE
# >> ****
# >> AND
# >> THEN
# >> UPCASED
# >> FINALLY
# >> JOINED
# >> WITH
# >> "\N"
