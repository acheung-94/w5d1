class MaxIntSet
  attr_reader :store
  def initialize(max)
    @max = max
    @store = Array.new(max)
  end

  def insert(num)
    self.validate!(num)
    @store[num] = true
  end

  def remove(num)
    self.validate!(num)
    @store[num] = false if @store[num] == true
  end

  def include?(num)
    self.validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    if num > @max || num < 0
      return false
    else
      return true
    end
  end

  def validate!(num)
    if is_valid?(num)
      num
    else
      raise 'Out of bounds'
    end
  end
end

class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
    return true
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num) ? true : false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    bucket = num % num_buckets
    @store[bucket]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if count < num_buckets
      unless self.include?(num)
        self[num] << num
        @count += 1
      end
    else
      self.resize!
      unless self.include?(num)
        self[num] << num
        @count += 1
      end
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    @store += Array.new(num_buckets) {Array.new}
    nums = @store.flatten
    nums.each do |num| #should all be unique at this point.
      self[num] << num 
    end
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    bucket = num % num_buckets
    @store[bucket]
  end
end