class Parent
  class << self
    def subclasses
      @subclasses ||= []
    end

    def inherited(klass)
      subclasses << klass
    end

    def meth_arghtest(*args)
      args
    end
  end
end

class Child1 < Parent; end
class Child2 < Parent; end
class Child3 < Parent
  class << self
    def meth_arghtest(*)
      super
    end
  end
  meth_arghtest 1, 2, 3 # => [1, 2, 3]
end
Parent.subclasses # => [Child1, Child2, Child3]

