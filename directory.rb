# this version has expanded student information!
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
    students << {
      name: name,
      cohort: :november,
      hobbies: 'trying to take over the world, I guess?',
      country_of_birth: 'Evil Volcano Island',
      height: 'all under 5 feet'
    }
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
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
    puts "Hobbies: #{student[:hobbies]}"
    puts "Birth Country: #{student[:country_of_birth]}"
    puts "Height: #{student[:height]}"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
students = input_students
print_header
print(students) # is this cool? print is already a built-in method
print_footer(students)
