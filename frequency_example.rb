# transform this:
name_list = ['bob', 'susan', 'james', 'susan', 'james', 'susan']

# into this
expected_result = { 'bob' => 1,  'susan' => 3, 'james' => 2 }

puts " expected result:  %s" % expected_result

reduce_result = name_list.reduce(Hash.new(0)) do |result, name|
  result[name] += 1
  result
end

puts "          reduce:  %s" % reduce_result

each_with_object_result = name_list.each_with_object(Hash.new(0)) do |name, accumulator|
  accumulator[name] += 1
end

puts "each_with_object:  %s" % each_with_object_result

accumulator_hash = Hash.new(0)

name_list.each do |name|
  accumulator_hash[name] += 1
end

puts "            each:  %s" % accumulator_hash
