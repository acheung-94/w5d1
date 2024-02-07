class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hashed = 0
    self.each_with_index do |num, i|
      combined = num.hash * i.hash
      hashed += combined
    end
    hashed
  end
end

class String # taco / coat
  def hash
    hashed = 0
    self.each_char.with_index do |char, i|
      combined = char.ord.hash * i.hash
      hashed += combined
    end
    hashed
  end
end

class Hash #DOES NOT CARE ABOUT ORDERING! 
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed = 0
    keys = self.keys
    keys.each do |k|
      combined = self[k].ord.hash
      hashed += combined
    end
    hashed
  end
end

