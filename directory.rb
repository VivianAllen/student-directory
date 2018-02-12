# this version only prints student names beginning with b!
def input_students
  puts 'Please enter the names of the students'
  puts 'To finish, just hit return twice'
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this vode
  while !name.empty? do
    # add to hash, all november cohort
    students << { name: name, cohort: :november }
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

def print_header
  puts 'The students of Villains Academy'
  puts '--------------'
end

def print(students)
  students.each do |student|
    if student[:name][0].casecmp('b').zero?
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
students = input_students
print_header
print(students) # is this cool? print is already a built-in method
print_footer(students)
