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

def display_instructions
  puts "A random string of colors will be generated"
  puts "(e.g. 'RRGB' - 'Red, Red, Green, Blue')."
  puts "Your job is to correctly guess the string in as few guesses as possible."
end

def display_game_start(difficulty_rating)
  puts "\nI have generated a sequence with #{difficulty_rating} elements made up of:"
  if difficulty_rating == 4
    puts "(r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game."
  elsif difficulty_rating == 6
    puts "(r)ed, (g)reen, (b)lue, (y)ellow, and (o)range. Use (q)uit at any time to end the game."
  else
    puts "(r)ed, (g)reen, (b)lue, (y)ellow, (o)range, and (m)agenta. Use (q)uit at any time to end the game."
  end
  puts "\nWhat's your guess?"
end

def determine_difficulty_rating
  difficulty = 0
  loop do
    puts "\nWhat difficulty level would you like to play?"
    puts "(b)eginner, (i)ntermediate, or (a)dvanced"
    answer = gets.chomp.downcase

    if answer.start_with?('b')
      difficulty = 4
      break
    elsif answer.start_with?('i')
      difficulty = 6
      break
    elsif answer.start_with?('a')
      difficulty = 8
      break
    else
      puts "Please enter a valid selection"
      puts "(b)eginner, (i)ntermediate, or (a)dvanced"
    end
  end
  difficulty
end

def verify_input(input, difficulty_rating)
  if input.length <= (difficulty_rating - 1)
    puts "Too short! -- Enter #{difficulty_rating} characters"
  elsif input.length > difficulty_rating
    puts "Too long! -- Enter #{difficulty_rating} characters"
  elsif input.length == difficulty_rating
    true
  end
end

def display_feedback(guess, secret, count)
  position_correct = 0
  elements_correct = 0
  guess_temp = guess.map { |color| color }

  secret.each do |secret_color|
    if guess_temp.include?(secret_color)
      elements_correct += 1
      guess_temp.delete_at(guess_temp.find_index(secret_color))
    end
  end

  guess.each_with_index do |guess_color, index|
    if guess_color == secret[index]
      position_correct += 1
    end
  end

  puts "'#{guess.join.upcase}' has #{elements_correct} of the correct elements"
  puts "with #{position_correct} in the correct positions."
  puts "You've taken #{count} guess" if count == 1
  puts "You've taken #{count} guesses" if count > 1
end
intro = %q{
                       WELCOME TO
     __  ______   _________________  __  ________  _____
    /  |/  / _ | / __/_  __/ __/ _ \/  |/  /  _/ |/ / _ \
   / /|_/ / __ |_\ \  / / / _// , _/ /|_/ // //    / // /
  /_/  /_/_/ |_/___/ /_/ /___/_/|_/_/  /_/___/_/|_/____/
}

puts intro
loop do
  puts "\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
  answer = gets.chomp.downcase

  if answer.start_with?('p')
    break
  elsif answer.start_with?('i')
    display_instructions
  elsif answer.start_with?('q')
    exit
  end
end

loop do
  difficulty = determine_difficulty_rating
  display_game_start(difficulty)
  board = initalize_game(difficulty)
  time_start = Time.new
  guess_counter = 0

  loop do
    user_guess = gets.chomp.upcase.chars

    if user_guess == board
      guess_counter += 1
      puts "YOU WIN!!"
      break
    elsif user_guess.include?('Q')
      exit
    elsif user_guess.include?('C')
      puts board.join.downcase
    elsif verify_input(user_guess, difficulty)
      guess_counter += 1
      display_feedback(user_guess, board, guess_counter)
    else
      puts "Guess again"
    end
  end

  time_end = Time.new
  time = time_end - time_start

  puts "Congratulations! You guessed the sequence '#{board.join}'"
  puts "in #{guess_counter} guesses over #{Time.at(time).utc.strftime("%M")} minutes, #{Time.at(time).utc.strftime("%S")} seconds."
  puts "\nDo you want to (p)lay again or (q)uit?"
  answer = gets.chomp.downcase
  if answer.start_with?('q')
    break
  end
end
