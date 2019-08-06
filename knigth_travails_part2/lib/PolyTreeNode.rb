require "byebug"

class PolyTreeNode
  attr_reader :value, :parent, :children


  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    if node != nil
      node.parent.children.delete(self) if node.parent != nil
      node.children << self if !node.children.include?(self) 
    end
    @parent = node
  end

  def inspect
    @value
  end

  def add_child(new_child)
    new_child.parent = self
  end

  def remove_child(old_child)
    raise "error" if !children.include?(old_child)
    old_child.parent = nil
  end

  def dfs(target)
    return self if self.value == target

    self.children.each do |child|
        current_search = child.dfs(target) #nil
        return current_search if !current_search.nil?
    end
    nil
  end

  def bfs(target)

    queue = []
    queue << self

    until queue.empty?
      # debugger
      node = queue.shift
      return node if node.value == target
        
      node.children.each do |child|
        queue << child
      end
    end
    nil


  end

end
