
class HashSet 
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    hashed = key.hash
    i = hashed % num_buckets
    if !@store[i].include?(hashed) 
      resize! if @count >= num_buckets
      @store[i] << hashed 
      @count += 1
    end
  end

  def include?(key)
    hashed = key.hash
    i = hashed % num_buckets
    @store[i].include?(hashed)
  end

  def remove(key)
    hashed = key.hash
    i = hashed % num_buckets
    if @store[i].include?(hashed)
      @store[i].delete(hashed)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % @store.length
    @store[i] << num
  end

  def num_buckets
    @store.length
  end

  def resize!
  end
end
