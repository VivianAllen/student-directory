# a quine is a program that takes no inputs and reads out its own
# source code.
File.open(__FILE__, 'r') do |file|
  file.readlines.each do |line|
    puts line
  end
end
