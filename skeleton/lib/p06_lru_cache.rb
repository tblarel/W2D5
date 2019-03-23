require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :map, :store

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
   # p key
    @map.include?(key) ? update_node!(@store[key]) : calc!(key) 
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    node = Node.new(key, @prc.call(key))
    @store.append(node.key, node.val)
    eject! if count >= @max
    @map.set( key, @store.get(key) )
  end

  def update_node!(node)
    p "being passed node #{node}"
    # suggested helper method; move a node to the end of the list
      @store.remove(node.key)
      @store.append(node.key, node.val)
  end

  def eject!
    oldest_node = @store.first.key
    @store.remove(oldest_node)
    @map.delete(oldest_node)
  end
end