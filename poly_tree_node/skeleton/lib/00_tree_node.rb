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

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Node is not a child" if !children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target)
    return self if self.value == target

    self.children.each do |child|
      result = child.dfs(target)
      return result if result
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      el = queue.shift
      return el if el.value == target
      el.children.each {|child| queue << child}
    end
    nil
  end
end
