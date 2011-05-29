# create_multiplier は インスタンスメソッドを作成する、
# クラスメソッド。
# 引数 fixed_factor は生成されたメソッドの中では固定値
# になり、arg で受け取るものが変数になる。
# 見た目の構造、パターンは似ているが、固定部分が異なるものは
# このようにメソッドを生成するメソッドで抽象化する事で
# DRY にできる。
class Example
  def self.create_multiplier(name, fixed_factor)
    define_method(name) do |arg|
      arg * fixed_factor
    end
  end
end

Example.create_multiplier(:double, 2)
Example.create_multiplier(:triple, 3)
Example.create_multiplier(:forth , 4)

eg = Example.new
eg.double(11) # => 22
eg.triple(11) # => 33
eg.forth(11)  # => 44

