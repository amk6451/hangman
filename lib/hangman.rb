require 'set'
require_relative 'save_game'
#reads file and stores in global variable memory
$lines = File.readlines("google-10000-english-no-swears.txt")

class Game

def initialize()
  @secret_word = pick_random_line()

  puts "Win before 8 guesses!, your secret word is: "
  puts "_" * @secret_word.length
  
  @secret_word_set = Set.new(@secret_word.split(//))
  @chosen_letters_set = Set.new()
  @count = 0
end  


def progress()
  p "Guessed letters"
  p @chosen_letters_set
  p "Total incorrect guesses: #{@count}"

end


def compare_set()
  #check of all letters of the secret word are included in our set of guess letters
  if @secret_word_set.subset?(@chosen_letters_set)
    puts "The secret word #{@secret_word}"
    return true
  end
  return false
end

def pick_letters()
  #asks the user to pick a letter
  puts "please give a valid letter, or enter (1) to save game or (2) for loading game" + "\n"
  letter = gets.chomp
  puts "#{letter}"
  #check for save command
  if letter.to_i == 1
      save_game()
      return
  end

  #check for load command
  if letter.to_i == 2
    load_game()
    return
  end

  #function runs again if letter already chosen, more than 1 letter, or not character not from alphabet
  if @chosen_letters_set.include?(letter) || letter.length != 1 || /^[a-zA-Z]$/.match(letter) == nil
      pick_letters
  else
    #adds lowercase letter to set of letters chosen
    return letter.downcase
    # @chosen_letters.add(letter.downcase)
  end
end

def update_blanks()
  #checks the players set of chosen letters against the "secret word"
  guess_word = Array.new(@secret_word.length,"_")
  @secret_word.split(//).each_with_index do |letter, index|
    #when a matched letter is found, the guessed word is updated
    if @chosen_letters_set.include?(letter)
      guess_word[index] = letter
    end
  end
  puts guess_word.join()
end

def hang_counter(selected)

  if selected == nil
    return @count
  end

  @chosen_letters_set.add(selected)
  if @secret_word_set.include?(selected)
    return @count
  else
    puts "Incorrect selection, number of bad counts is #{@count+1}"
    return @count += 1
  end
end


def pick_random_line()
    #randomly select a word between 5 and 12 characters long
    selection = $lines[rand($lines.length)].chomp
    if selection.length > 5 && selection.length < 12
      #returns secret word
      return selection
    else
      pick_random_line()
    end
  end
end

x = Game.new()

while true
  # x.display_guesses(guess_word)
  value = x.pick_letters()

  #if more than 7 guesses, game ends
  if x.hang_counter(value) > 7
    puts "you lose, you had too many guesses"
    break
  end
  
  x.update_blanks()
  x.progress()

  #true means all secret letters were correctly guessed correctly
  if x.compare_set() == true
    puts "game is finished, you win"
    break
  end
end

