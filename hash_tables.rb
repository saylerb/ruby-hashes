# Hash tables - the key is the index we use to retrieve an item from the collection

# They have a constant lookup time (O(1))

# Super fast!

# Hash tables (as a general rule) have no concept of order

# You need a large footprint of memory to store your hashes without collisions

# Hashing algorithms:
# - need to be idempotent: (a single input always returns the same output)
# - needs to be fast! algorithm speed > cryptographically secure (e.g. SHA256)
#

# With the hash table, you want to store a value, and be able to check lter
# Collection needs to be large enough to avoid collisions (255 seems like enough for small strings)

class HashTable
  attr_reader :buckets, :buckets_count
  def initialize
    @buckets_count = 255
    @buckets = Array.new(buckets_count)
  end

  def hash(input, max)
    total = 0

    input.chars.each do |char|
      total += char.ord
    end

    total % max
  end

  def >>(input)
    buckets[hash(input, buckets_count)] = input
  end

  def contains?(input)
    !!buckets[hash(input, buckets_count)]
  end
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'

class TestHashTable < Minitest::Test
  def test_it_hashes_a_string_to_a_number_between_0_and_max
    table = HashTable.new

    assert_includes 0..10, table.hash('hello', 10)
    assert_includes 0..50, table.hash('hello', 50)
    assert_includes 0..255, table.hash('hello', 255)
    assert_includes 0..255, table.hash('world', 255)
  end

  def test_it_adds_string_to_the_table
    table = HashTable.new
    table >> 'hello'
    table >> 'world'

    assert_equal table.buckets[22], 'hello'
    assert_equal table.buckets[42], 'world'
  end

  def test_it_can_check_if_values_exist
    table = HashTable.new
    table >> 'hello'
    table >> 'world'

    assert table.contains?('hello')
    assert table.contains?('world')
    refute table.contains?('what')
    refute table.contains?('okay')
  end

  def test_hashing_is_idempotent
    table = HashTable.new
    assert_equal table.hash('hello', 50), table.hash('hello', 50)
    assert_equal table.hash('hello', 255), table.hash('hello', 255)
    refute_equal table.hash('hello', 10), table.hash('hello', 255)
  end
end
