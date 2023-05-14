require 'json'
def save_game()
    p "Please write a username to save your progress"
    username = gets.chomp

    #creates a new .json file starting with the username
    filename = "saves/#{username}_game.json"
    File.open(filename,'w') do |file|
    file.write(write_json)
    end
end

def write_json()
    #takes local variables from current game and serializes them to json format
    JSON.dump({
        secret_word: @secret_word,
        chosen_letters_set: @chosen_letters_set,
        count: @count
            })
end
