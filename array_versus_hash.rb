# Demo
# Arrays list information in order, zero indexed
# Hashes act as a dictionary

require 'benchmark'

names = ['Yehuda', 'David', 'Matz', 'Sandi']

grades = ['A', 'B-', 'A+', 'B+']

projects = ['Sorting Suite', 'Black Thursday', 'Little Shop', 'The Pivot']

# Now, what if we wanted to draw connections between these pieces of data?
# Information is stored across lists at a common index (e.g. Max is at the 3rd index)

# Problems:
# Association is not stored in a common place.
# It gets messy if I have a lot of information to keep track of
# Must maintain multiple lists
# Always index using integers
# Coupling: must remember to change mutliple lists and keep them of the same length

# Lists need to be

def get_grade(student, name_list, grade_list, project_list)
  index = name_list.index(student) # => returns the index number
  grade = grade_list[index]
  project = project_list[index]

  return [project, grade]
end

#puts get_grade('Ana', names, grades, projects).inspect
#puts get_grade('John', names, grades, projects).inspect
#puts get_grade('Max', names, grades, projects).inspect
#puts get_grade('Kay', names, grades, projects).inspect


# Solution: using a Hash

# Stores pairs of data: key and value
# I can index and retrieve item of interest directly
# I can use a single data structure

# TODO: Lookups

grade_hash = { 'Yehuda' => 4, 'David' => 3, 'Matz' => 4, 'Sandi' => 2 }

# Benchmarking

Benchmark.bm(10) do |x|
  x.report("Array indexing:") { get_grade('Sandi', names, grades, projects) }
end

method_time = Benchmark.realtime do
  get_grade('Sandi', names, grades, projects)
end

array_time = Benchmark.realtime do
  grades[4]
end

hash_time = Benchmark.realtime do
  grade_hash['Sandi']
end


puts "Method time elapsed #{method_time * 1000} milliseconds"
puts "Array time elapsed #{array_time * 1000} milliseconds"
puts "Hash time elapsed #{hash_time * 1000} milliseconds"


