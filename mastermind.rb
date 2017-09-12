# this is a comment
FOUR_COLORS = %w(R G B Y)
FIVE_COLORS = %w(R G B Y O)
SIX_COLORS = %w(R G B Y O M)

def initalize_game(difficulty_rating)
  rando = []
  if difficulty_rating == 4
    4.times { rando << FOUR_COLORS.sample }
    rando
  elsif difficulty_rating == 6
    6.times { rando << FIVE_COLORS.sample }
    rando
  elsif difficulty_rating == 8
    8.times { rando << SIX_COLORS.sample }
    rando
  end
end

def start_game
  initialize_game
  puts "I have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game."
  take_a_guess
end

def display_instructions
  puts "\nA random string of colors will be generated"
  puts "(e.g. 'RRGB' - 'Red, Red, Green, Blue')."
  puts "Your job is to correctly guess the string in as few guesses as possible."
end

def quit
  puts "bye bye"
  exit
end

def quit_or_cheat(user_input)
  if user_input == "q" ||  user_input == "quit"
    quit
  elsif user_input == "c" || user_input == "cheat"
    puts "WINNING COMBO: #{@winning_combo.join('').upcase}"
    take_a_guess
  end
end

def take_a_guess
  puts "\nWhat's your guess?"
  user_input = gets.chomp.downcase
  quit_or_cheat(user_input)
  if valid_input(user_input)
    @guess_counter += 1
    check_guess(valid_input)
  else
    take_a_guess
  end
end

def check_guess(user_input)
  if user_input == @winning_combo.join('')
    puts 'Winner!!!!!'
    puts "Congratulations! You guessed the sequence '#{@winning_combo.join("").upcase}' in #{@guess_counter} guesses"
    puts "\nDo you want to (p)lay again or (q)uit?"
    start_input
  else
    feedback(user_input)
    take_a_guess
  end
end

def valid_input(user_input)
  if user_input.length < 4
    puts "guess is too short, must be four characters"
    false
  elsif user_input.length > 4
    puts "guess is too long. must be four characters"
    false
  else
    true
  end
end

def initialize_game
  @winning_combo = []
  @guess_counter = 0
  4.times { @winning_combo << COLORS.sample }
end

def feedback(user_input)
  puts elements_correct(user_input)
  puts guess_count
  puts postions_correct(user_input)
end

def guess_count
  "You have taken #{@guess_counter} guesses"
end

def elements_correct(user_input)
  winning_combo_dup = @winning_combo.dup
  user_input.split('').each do |l|
    if winning_combo_dup.include?(l)
      winning_combo_dup.delete_at(winning_combo_dup.index(l) || winning_combo_dup.length)
    end
  end
  num_correct = user_input.length - winning_combo_dup.length
  "'#{user_input}' has #{num_correct} of the correct elements"
end

def postions_correct(user_input)
  num_correct = 0
  @winning_combo.each_with_index do |l, i|
    if user_input[i] == @winning_combo[i]
      num_correct += 1
    end
  end
  "You have #{num_correct} in the correct positions"
end

start
