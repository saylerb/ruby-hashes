require 'benchmark'

NUMBERS_ARRAY = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
NUMBERS_HASH = { 1 => 1, 2 => 1, 3 => 1, 4 => 1, 5 => 1,
                 6 => 1, 7 => 1, 8 => 1, 9 => 1, 10 => 1
               }

def find_summing_numbers(target)

  # find two numbers from a grouping of integers which add up to target, return array of two values
  # if no matches are found, return an array of two nil's
  total = 0

  NUMBERS_ARRAY.each_with_index do |first_num, index|
    NUMBERS_ARRAY[index + 1..NUMBERS_ARRAY.length].each do |second_num|
      total += 1
      if first_num + second_num == target
        return [first_num, second_num, "total loops: %s" % total]
      end
    end
  end

  return [nil, nil, "total loops: %s" % total]

end

def find_summing_numbers_hash(target)
    total = 0
  NUMBERS_HASH.keys.each do |num|
    total += 1
    if NUMBERS_HASH[target - num]
      return [num, target - num, "total loops: %s" % total]
    end

    return [nil, nil, "total loops: %s" % total]
  end
end

puts find_summing_numbers(10).inspect
puts find_summing_numbers_hash(10).inspect

GC.disable

Benchmark.bm(10) do |bench|
  bench.report("using array") do
    1_000_000.times do
      find_summing_numbers(5)
    end
  end

  bench.report("using hash") do
    1_000_000.times do
      find_summing_numbers_hash(5)
    end
  end
end

GC.enable

