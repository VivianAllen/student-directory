@students = []

def check_quit(name)
  if name.empty?
    puts 'Enter blank name again to quit, enter name to continue'
    input = STDIN.gets.chomp
    input.empty? ? false : input
  else
    name
  end
end

def check_input(input)
  puts "You entered #{input}. Is that correct?"
  answer = ''
  until %w[y n].include?(answer)
    puts 'Please enter y or n'
    answer = STDIN.gets.chomp
  end
  answer.casecmp('y').zero? ? true : false
end

def input_name
  loop do
    puts 'Please enter students name'
    name = check_quit(STDIN.gets.chomp)
    return false unless name
    return name if check_input(name)
  end
end

def input_cohort
  loop do
    puts 'Please enter students cohort'
    cohort = STDIN.gets.chomp
    if cohort.empty?
      puts 'If no input detected, default (November cohort) will be used'
      cohort = 'November'
    end
    return cohort if check_input(cohort)
  end
end

def add_student(name, cohort)
  @students << { name: name, cohort: cohort.to_sym }
end

def count_students
  student_string = @students.count > 1 ? 'students' : 'student'
  puts "Now we have #{@students.count} #{student_string}"
end

def input_students
  puts 'Please enter the students details'
  puts 'To finish, enter a blank name twice'
  loop do
    name = input_name
    return unless name
    add_student(name, input_cohort)
    count_students
  end
end

def print_header
  puts 'The students of Villains Academy'
  puts '--------------'
end

def print_student_list
  return if @students.count.zero?
  @students.each do |student|
    puts "#{student[:name].center(20)}
     (#{student[:cohort].to_s.center(9)} cohort)"
  end
end

def save_students
  # open the file for writing
  file = File.open('students.csv', 'w')
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(',')
    file.puts csv_line
  end
  file.close
end

def load_students(filename = 'students.csv')
  file = File.open(filename, 'r')
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    add_student(name, cohort)
  end
  file.close
end

def try_load_students
  filename = ARGV.first.nil? ? 'students.csv' : ARGV.first
  if File.exist?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def print_cohorts
  return if @students.count.zero?
  cohorts = @students.map { |student| student[:cohort] }.uniq
  # determine membership of each cohort
  cohorts.each do |cohort|
    puts "Students in #{cohort} cohort:"
    @students.each do |student|
      puts student[:name] if student[:cohort] == cohort
    end
  end
end

def print_footer
  return if @students.count.zero?
  student_string = @students.count > 1 ? 'students' : 'student'
  puts "Overall, we have #{@students.count} great #{student_string}"
end

def print_menu
  puts '1. Input the students'
  puts '2. Show the students'
  puts '3. Save the list to students.csv'
  puts '4. Load the list from students.csv'
  puts '9. Exit'
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
  when '1'
    input_students
  when '2'
    show_students
  when '3'
    save_students
  when '4'
    load_students
  when '9'
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

## script below ##
try_load_students
interactive_menu
