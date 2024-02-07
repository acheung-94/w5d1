class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if count < num_buckets
      unless self.include?(key)
        self[key] << key
        @count += 1
      end
    else
      self.resize!
      unless self.include?(key)
        self[key] << key
        @count += 1
      end
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self.include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    @store += Array.new(num_buckets) {Array.new}
    keys = @store.flatten
    keys.each do |key| #should all be unique at this point.
      self[key] << key 
    end
  end

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    hash_key = key.hash
    bucket = hash_key % num_buckets
    @store[bucket]
  end
end