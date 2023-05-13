require 'set'
#reads file and stores in memory
$lines = File.readlines("google-10000-english-no-swears.txt")

class Game

def initialize()
  @secret_word = pick_random_line()
  @guess_word = Array.new(@secret_word.length,"_")
  @chosen_letters = Set.new()
end  

def display_guesses()
  p @guess_word.join()
end

def chosen_letters()
  p @chosen_letters.join(//)
end

def pick_letters()
  #asks the user to pick a letter
  puts "please give a valid letter" + "\n"
  letter = gets.chomp
  #function runs again if letter already chosen, more than 1 letter, or not character not from alphabet
  if @chosen_letters.include?(letter) || letter.length != 1 || /^[a-zA-Z]$/.match(letter) == nil
    pick_letters
  else
    #adds lowercase letter to set of letters chosen
    @chosen_letters.add(letter.downcase)
    p @chosen_letters
  end
end

def update_blanks()
  #checks the players set of chosen letters against the "secret word"
  @secret_word.each_with_index do |letter, index|
    #when a matched letter is found, the guessed word is updated
    if @chosen_letters.include?(letter)
      @guess_word[index] = letter
    end
  end
end


def pick_random_line()
    #randomly select a word between 5 and 12 characters long
    selection = $lines[rand($lines.length)].chomp
    if selection.length > 5 && selection.length < 12
      #returns an array of the string
      return selection.split(//)
    else
      pick_random_line()
    end
  end


end

x = Game.new()

while true
  x.display_guesses()
  x.pick_letters()
  x.update_blanks()

end

