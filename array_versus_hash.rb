# Demo
# Arrays list information in order, zero indexed
# Hashes act as a dictionary

require 'benchmark'

GC.disable
#names = ['Yehuda', 'David', 'Matz', 'Sandi']
names = ['Yehuda', 'David', 'Matz', 'Sandi', '5', '6', '7', '8', '9', '10', '11', '12', '13']

#twitter_handle = ['wycats', 'dhh', 'yukihiro_matz', 'sandimetz']
twitter_handle = ['wycats', 'dhh', 'yukihiro_matz', 'sandimetz', '5', '6', '7', '8', '9', '10', '11', '12', '13']

followers = [58_679, 192_471, 45_840, 20_400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300]

locations = ['Portland', 'Chicago', 'Matsue', 'Durham', 'NYC', 'Dallas', 'San Fransisco', 'Pune', 'Paris', 'London', 'Seattle', 'Miami', 'Charlotte']
#locations = ['Portland', 'Chicago', 'Matsue', 'Durham']

# Now, what if we wanted to draw connections between these pieces of data?
# Information is stored across lists at a common index (e.g. Max is at the 3rd index)

# Problems:
# Association is not stored in a common place.
# It gets messy if I have a lot of information to keep track of
# Must maintain multiple lists
# Always index using integers
# Coupling: must remember to change mutliple lists and keep them of the same length

# Lists need to be

def get_data(name, names_list, followers_list, locations_list)
  index = names_list.index(name) # => returns the index number
  followers = followers_list[index]
  location = locations_list[index]

  return [followers, location]
end

#puts get_data('Yehuda', names, followers, locations).inspect
#puts get_data('David', names, followers, locations).inspect
#puts get_data('Matz', names, followers, locations).inspect
#puts get_data('Sandi', names, followers, locations).inspect

# Solution: using a Hash

# Stores pairs of data: key and value
# I can index and retrieve item of interest directly
# I can use a single data structure

# TODO: Lookups

#followers_hash = { 'Yehuda' => 58_679, 'David' => 192_471, 'Matz' => 45_840, 'Sandi' => 20_400 }
#followers_hash = { 'Yehuda' => 58_679, 'David' => 192_471, 'Matz' => 45_840, 'Sandi' => 20_400, 'Brian' => 20_000, 'Erin' => 20_000, 'Nick' => 20_000, 'Jeff' => 1_000_000, 'Josh' => 1, 'Meeka' => 100, 'what' => 100, 'wowow' => 10_000, 'hello' => 1_000 }

followers_hash = { :Yehuda => 58_679, :David => 192_471, :Matz => 45_840, :Sandi => 20_400, :Brian => 20_000, :Erin => 20_000, :Nick => 20_000, :Jeff => 1_000_000, :Josh => 1, :Meeka => 100, :what => 100, :wowow => 10_000, :hello => 1_000 }

#
# Benchmarking

#Benchmark.bm(10) do |x|
#  x.report("Array indexing:") { get_data('Sandi', names, followers, locations) }
#end


puts get_data('12', names, followers, locations).inspect
method_time = Benchmark.realtime do
  1_000_000.times do
    get_data('13', names, followers, locations)
  end
end

puts followers[12].inspect
array_time = Benchmark.realtime do
  1_000_000.times do
    followers[12]
  end
end

puts followers_hash[:hello].inspect
hash_time = Benchmark.realtime do
  1_000_000.times do
    #followers_hash[:hello]
    followers_hash.dig(:hello)
  end
end

GC.enable

puts "Method time elapsed #{method_time * 1000} milliseconds"
puts "Array time elapsed #{array_time * 1000} milliseconds"
puts "Hash time elapsed #{hash_time * 1000} milliseconds"

