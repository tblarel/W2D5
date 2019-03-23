class MaxIntSet
  def initialize(max)
    @max = max
    @set = []
  end

  def insert(num)
    raise 'Out of bounds' if num >= @max || num < 0
    return @set << num if !include?(num) && @set.length < @max
  end

  def remove(num)
    @set.delete(num)
  end

  def include?(num)
    @set.include?(num)
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    i = num % 20
    @store[i] << num if !include?(num)
  end

  def remove(num)
    i = num % 20
    @store[i].delete(num) if include?(num)
  end

  def include?(num)
    i = num % 20
    @store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @num_buckets = num_buckets
    @store = Array.new(@num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num)
      resize! if count >= num_buckets
      i = num % @num_buckets
      @store[i] << num 
      @count += 1 
    end
  end

  def remove(num)
    i = num % @num_buckets
    if include?(num)
      @store[i].delete(num) 
      @count -= 1 
    end
  end

  def include?(num)
    i = num % @num_buckets
    @store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets *= 2
    resized = Array.new(@num_buckets) { Array.new }
 
    @store.each do |bucket|
      bucket.each do |item|
        i = item % @num_buckets
        resized[i] << item 
      end
    end

    @store = resized
  end

end
