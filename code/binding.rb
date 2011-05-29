# binding について # !> instance variable @ivar not initialized
#==================================================================
# binding とはプログラム実行の特定の時点のコンテキストをカプセル化
# したオブジェクトの事
# eval の引数に binding を明示的に与えてやれば、eval が評価される
# コンテキスト(=文脈)を変える事ができる。
# コンテキストとは具体的には、ローカル変数テーブルや、self が何を
# 指すか？といった環境の事。
# 文脈が変われば言葉の意味が変わるように、binding が変われば、同じ
# 変数 ivar が何を指すか(何の値として評価されるか?)も変わるのだ。
#-----------------------------------------------------------------
class A
  attr_accessor :ivar
  def initialize
    @ivar = 123
  end

  def get_binding
    ivar = "ivar"
    binding
  end
end

a = A.new
binding_obj = a.get_binding
ivar = "outer ivar"

eval "ivar"                         rescue $!.class # => "outer ivar"
eval "@ivar"                        rescue $!.class # => nil
eval "self.ivar"                    rescue $!.class # => NoMethodError

# 同じ
eval "ivar"      , TOPLEVEL_BINDING rescue $!.class # => "outer ivar"
eval "@ivar"     , TOPLEVEL_BINDING rescue $!.class # => nil
eval "self.ivar" , TOPLEVEL_BINDING rescue $!.class # => NoMethodError


# with binding object
eval "ivar"     , binding_obj # => "ivar"
eval "@ivar"    , binding_obj # => 123
eval "self.ivar", binding_obj # => 123

a.ivar = "new value"
eval "ivar"     , binding_obj # => "ivar"
eval "@ivar"    , binding_obj # => "new value"
eval "self.ivar", binding_obj # => "new value"
