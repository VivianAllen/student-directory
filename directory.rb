@students = []

def input_name
  blanks = 0
  loop do
    case blanks
    when 1
      puts 'enter blank name again to quit'
    when 2
      return nil
    end
    puts 'Please enter students name'
    name = STDIN.gets.chomp
    if name.empty?
      blanks += 1
    else
      puts "You entered #{name}. Is that correct? y/n"
      input = STDIN.gets.chomp
      until %w[y n].include?(input)
        puts 'Please enter y or n'
        input = STDIN.gets.chomp
      end
      return name if input.casecmp('y').zero?
    end
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
    puts "You entered #{cohort}. Is that correct? y/n"
    input = STDIN.gets.chomp
    until %w[y n].include?(input)
      puts 'Please enter y or n'
      input = STDIN.gets.chomp
    end
    return cohort.to_sym if input.casecmp('y').zero?
  end
end

def input_students
  students = []
  puts 'Please enter the students details'
  puts 'To finish, just hit enter a blank name twice'
  loop do
    name = input_name
    break if name.nil?
    cohort = input_cohort
    students << { name: name, cohort: cohort }
    student_string = students.count > 1 ? 'students' : 'student'
    puts "Now we have #{students.count} #{student_string}"
  end
  students
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
    @students << { name: name, cohort: cohort.to_sym }
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
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
    @students = input_students
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
