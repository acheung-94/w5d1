class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next
    self.next.prev = self.prev
  end

end

class LinkedList
  include Enumerable
  attr_reader :head, :tail

  def initialize
    
    @head = Node.new
    @tail = Node.new
    head.next = tail
    tail.prev = head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail
  end

  def get(key)

    self.each do |node|
      return node.val if node.key == key
    end
    nil

  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    last.next = new_node
    new_node.prev = last

    tail.prev = new_node
    new_node.next = tail
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
      end
    end
  end

  def remove(key)
    node = get(key)
    return nil if node.nil?
    self.each do |node|
      if node.key == key
        downstream = node.next
        upstream = node.prev
        upstream.next = downstream
        downstream.prev = upstream
      end
    end
  end

  def each(&blk)
    current_node = first
    until current_node == tail
      blk.call(current_node)
      current_node = current_node.next
    end
    self
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end

# list = LinkedList.new
# list.append(:cat, 4)
# list.append(:dog, 5)
# list.append(:meow, 2)
 
# list.remove(:dog)
# p list.get(:cat).prev.key
# p list.get(:cat).next.key
# p list.include?(:cat)
# p list.include?(:dog)