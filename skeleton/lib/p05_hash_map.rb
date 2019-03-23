require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket = bucket(key)
    bucket.include?(key)
  end

  def set(key, val)
    resize! if @count > @store.length
    bucket = bucket(key)
    if include?(key)
      bucket.update(key, val) 
    else 
      bucket.append(key,val)
      @count += 1
    end
  end

  def get(key)
    bucket = bucket(key)
    bucket.get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield(node.key,node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

#set(key, val)

  def resize!
    p "I am resizing!"
    new_store =  Array.new(@store.length * 2){ LinkedList.new }
    @store.each do |list|
      list.each do |node|
        new_bucket = node.key.hash % new_store.length
        new_store[new_bucket].append(node.key,node.val)
      end
    end
    @store = new_store
  end

  def bucket(key)
    @store[key.hash % @store.length]
    # optional but useful; return the bucket corresponding to `key`
  end
end
