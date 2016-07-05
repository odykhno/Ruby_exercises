class PrefixTreeNode
  def initialize key, is_key = false
    @key = key
    @children = {}
    @let_count
  end

  attr_reader :key
  attr_accessor :children, :is_key, :let_count

end