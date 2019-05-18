require "byebug"
class PolyTreeNode
  def initialize(value)
    @value = value
    @parent  = nil
    @children = []
  end

  def parent=(node)
    if self.parent != nil
      self.parent.children.delete(self)
    end
    @parent = node
    node.children << self unless node == nil || node.children.include?(self)
  end

  def add_child(new_child)
    new_child.parent=(self)
  end

  def remove_child(child_node)
    if self.children.include?(child_node)
      child_node.parent=(nil)
    else         
      raise "error"
    end
    
  end
  def inspect
    "<PolyTreeNode #{self.object_id} >"
  end 

  def dfs(target)
    return self if self.value == target
      self.children.each do |child|
          tn = child.dfs(target) 
          return tn if tn != nil

      end     
    nil
  end

  def bfs(target)
    
    data = [self]

    until data.empty?
      cur_node = data.shift
      
      if cur_node.value == target
        return cur_node
      end
      data += cur_node.children
    end
    nil
  end

  attr_reader :parent, :children, :value
end


