COLORS = ["r", "g", "b", "y"]

@winning_combo = []

def start
  puts "Welcome to MASTERMIND\n"
  options
end

def options
  puts "\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
  start_input
end

def start_input
  user_input = gets.chomp.downcase
  if user_input == "p" || user_input == "play"
    start_game
  elsif user_input == "i" || user_input == "instructions"
    instructions
  elsif user_input == "q" || user_input == "quit"
    quit
  else
    options
  end
end

def start_game
  generate_winning_combo
  puts "I have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game."
  take_a_guess
end

def instructions
  puts "These are your instructions"
end

def quit
  puts "bye bye"
end

def take_a_guess
  puts "\nWhat's your guess?"
  user_input = gets.chomp.downcase
  check_length(user_input)
end

def check_guess(user_input)
  puts "WINNING COMBO: #{@winning_combo.join('')}" # remove me!!!!

  if user_input == @winning_combo.join('')
    puts 'Winner!!!!!'
  else
    take_a_guess
  end
end

def check_length(user_input)
  if user_input.length < 4
    puts "guess is too short, must be four characters"
    take_a_guess
  elsif user_input.length > 4
    puts "guess is too long. must be four characters"
    take_a_guess
  else
    check_guess(user_input)
  end
end

def generate_winning_combo
  4.times { @winning_combo << COLORS.sample }
end

start
