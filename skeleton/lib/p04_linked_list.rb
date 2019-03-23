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
  end
end

class LinkedList
  include Enumerable

  attr_accessor :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    counter = 0
    curr_node = @head.next
    until curr_node == @tail
      return curr_node if counter == i
      counter += 1 
      curr_node = curr_node.next
    end
    nil
    # each_with_index { |link, j| return link if i == j }
    # nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next.val.nil?
  end

  def get(key)
    curr_node = @head.next
    until curr_node == @tail
      return curr_node.val if curr_node.key == key 
      curr_node = curr_node.next
    end
    nil
  end

  def include?(key)
    get(key).nil? ? false : true
  end

  def append(key, val)
    node = Node.new(key, val)
    node.prev = @tail.prev
    node.next = @tail
    @tail.prev.next = node 
    @tail.prev = node
  end

  def update(key, val)
    curr_node = @head.next
    until curr_node == @tail
      curr_node.val = val if curr_node.key == key 
      curr_node = curr_node.next
    end
  end

  def remove(key)
    curr_node = @head.next
    until curr_node == @tail
      if curr_node.key == key 
        curr_node.prev.next = curr_node.next
        curr_node.next.prev = curr_node.prev
      end
      curr_node = curr_node.next
    end
  end

  def each
    all_vals = []
    curr_node = @head.next
    until curr_node == @tail
      yield curr_node
       curr_node = curr_node.next
    end
    return all_vals
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

a = LinkedList.new


#puts "head's next is #{a.head.next} and that nexts' value is #{a.head.next.val}"
