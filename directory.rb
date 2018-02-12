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
    name = gets.chomp
    if name.empty?
      blanks += 1
    else
      puts "You entered #{name}. Is that correct? y/n"
      input = gets.chomp
      until %w[y n].include?(input)
        puts 'Please enter y or n'
        input = gets.chomp
      end
      return name if input.casecmp('y').zero?
    end
  end
end

def input_cohort
  loop do
    puts "Please enter students cohort"
    cohort = gets.chomp
    if cohort.empty?
      puts "If no input detected, default (November cohort) will be used"
      cohort = 'November'
    end
    puts "You entered #{cohort}. Is that correct? y/n"
    input = gets.chomp
    until %w[y n].include?(input)
      puts 'Please enter y or n'
      input = gets.chomp
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
    puts "Now we have #{students.count} students"
  end
  students
end

def print_header
  puts 'The students of Villains Academy'
  puts '--------------'
end

def print(students)
  students.each do |student|
    puts "#{student[:name].center(20)}
     (#{student[:cohort].to_s.center(9)} cohort)"
  end
end

def print_cohorts(students)
  cohorts = students.map { |student| student[:cohort] }.uniq
  # determine membership of each cohort
  cohorts.each do |cohort|
    puts "Students in #{cohort} cohort:"
    students.each do |student|
      puts student[:name] if student[:cohort] == cohort
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end
students = input_students
print_header
print_cohorts(students) # is this cool? print is already a built-in method
print_footer(students)
