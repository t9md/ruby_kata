require "rubygems"
require "parse_tree"

class T9md
  def talk
    "hoyoyo"
  end
  def sleep(name)
    "zzz...#{name}"
  end
end
p = ParseTree.new
puts p.parse_tree(T9md).to_yaml
# >> --- 
# >> - - :class
# >>   - :T9md
# >>   - - :const
# >>     - :Object
# >>   - - :defn
# >>     - :sleep
# >>     - - :scope
# >>       - - :block
# >>         - - :args
# >>           - :name
# >>         - - :dstr
# >>           - zzz...
# >>           - - :evstr
# >>             - - :lvar
# >>               - :name
# >>   - - :defn
# >>     - :talk
# >>     - - :scope
# >>       - - :block
# >>         - - :args
# >>         - - :str
# >>           - hoyoyo
