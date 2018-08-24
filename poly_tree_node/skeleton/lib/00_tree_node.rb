class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(parent)
    self.parent.children.delete(self) if self.parent
    @parent = parent
    parent.children << self unless parent == nil ||
      parent.children.include?(self)
  end


end
