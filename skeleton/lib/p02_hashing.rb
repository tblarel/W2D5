class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    total = 0
    self.each_with_index do |el,idx|
      total += (el.hash * idx)
    end
    return total
  end
end

class String
  def hash
    alphabet = ('a'..'z').to_a
    total = 0
    self.each_char.each_with_index do |char,idx|
      charidx = alphabet.index(char)
      total += (charidx.hash * idx)
    end
    total
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    total = 0
    self.each do |k,v|
      hashed_key = k.hash
      hashed_val = v.hash
      total += (hashed_val * hashed_key).hash
    end
    total
  end
end


