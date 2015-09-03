def instructions
  puts "=== Instructions ==="
  puts "Guess the correct sequence of colors!"
end

def quit
  puts "Thank you for playing!"
end

def generate_secret_sequence
  letter_options = ["r", "g", "b", "y"]
  secret_sequence = ""
  4.times do
    secret_sequence << letter_options.sample
  end
  secret_sequence
end

def sequence_correct(response, secret_sequence)
  response_array = response.split("")
  secret_sequence_array = secret_sequence.split("")
  correct_positions = []
  4.times do |i|
    if response_array[i] == secret_sequence[i]
      correct_positions << i
    end
  end
    return correct_positions.length.to_s
end

def letters_correct(response, secret_sequence)
  response_array = response.split("")
  secret_sequence_array = secret_sequence.split("")
  correct_letters = []
  4.times do |i|
    if secret_sequence_array.include?(response_array[i])
        correct_letters << response_array[i]
        secret_sequence_array.delete_at(secret_sequence_array.index(response_array[i]))
    end
  end
    return correct_letters.length.to_s
end

def give_user_feedback(response, secret_sequence, number_of_guesses)
  if response == secret_sequence
  else
    puts "'#{response.upcase}' has #{letters_correct(response, secret_sequence)} correct elements with #{sequence_correct(response, secret_sequence)} in the correct positions"
    puts "You've taken #{number_of_guesses} guesses"
  end
end

def eval_player_guess_length(player_guess, secret_sequence, number_of_guesses)
  until player_guess.length == 4 || player_guess == "q" || player_guess == "c"
    if player_guess.length < 4
      puts "Your guess is too short."
      player_guess = gets.chomp.downcase
    elsif player_guess.length > 4
      puts "Your guess is too long"
      player_guess = gets.chomp.downcase
    end
  end
  eval_player_guess(player_guess, secret_sequence, number_of_guesses)
end

def eval_player_guess(player_guess, secret_sequence, number_of_guesses)
  if player_guess.length == 4
    give_user_feedback(player_guess, secret_sequence, number_of_guesses)
  elsif player_guess == "c"
    puts "The secret is #{secret_sequence}"
  end
  return player_guess.to_s
end

def game_flow
  secret_sequence = generate_secret_sequence
  puts "**** The secret sequence is #{secret_sequence} ****"
  puts  "I have generated a beginner sequence with four elements made up of: (r)ed,
        (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.
        What's your guess?"
  start_time = Time.now
    @minutes = 0
    @seconds = 0
    number_of_guesses = 0
    player_guess = ""
  loop do
  player_guess = gets.chomp.downcase
  number_of_guesses += 1
  @new_player_guess = eval_player_guess_length(player_guess, secret_sequence, number_of_guesses)

  break if player_guess == secret_sequence || player_guess == "q" || @new_player_guess == secret_sequence || @new_player_guess == "q"
  end
  if player_guess == "q" || @new_player_guess == "q"
    quit
  else
    end_time = Time.now
    find_gameplay_time(start_time, end_time)
    puts "Congratulations! You guessed the sequence '#{secret_sequence.upcase}' in #{number_of_guesses} guesses over #{@minutes} minutes and #{@seconds} seconds."
    puts "Do you want to (p)lay again or (q)uit?"
    player_response = gets.chomp.downcase
      if player_response == "q"
        quit
      elsif player_response == "p"
        start_game
      end
    end
  end

def find_gameplay_time(start_time, end_time)
  game_length = end_time - start_time
  @minutes = game_length.to_i / 60
  @seconds = game_length.to_i - (@minutes * 60)
end

def start_game
puts "Welcome to MASTERMIND"

puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
player_start_choice = gets.chomp.downcase
  if player_start_choice == "p"
    game_flow
  elsif player_start_choice == "i"
    instructions
    game_flow
  elsif player_start_choice == "q"
    quit
  end
end

start_game


# Notes
  # No extensions
  # Mixed use of "response" and "user answer"
  # ERROR: For secret "ggyg" - answer "gggg" shows as having 4 correct elements
