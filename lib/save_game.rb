require 'json'
require "set"

def save_game()
    p "Please write a username to save your progress"
    username = gets.chomp

    #creates a new .json file starting with the username
    filename = "saves/#{username}_game.json"
    File.open(filename,'w') do |file|
    file.write(write_json)
    end
    p "Saved successfully!"
end

def write_json()
    #takes local variables from current game and serializes them to json format
    JSON.dump({
        secret_word: @secret_word,
        #set formatted to array for ease of deserializing step later
        chosen_letters_set: @chosen_letters_set.to_a,
        count: @count
            })
end



def load_game
    puts "Choose a game by it's username: "
    display_save_games()
    game_to_load = gets.chomp
    data = read_json( "saves/#{game_to_load}_game.json" )
end

def display_save_games()
    #displays each saved username game in the saves directory
    games_array = Dir.glob('saves/*.json')
    games_array.each do |game|
        puts File.basename(game,"_game.json")
    end
end

def read_json(save_game)
    json_data = JSON.parse(File.read(save_game))
    puts "json_data retrieved"

    @secret_word = json_data['secret_word']
    @secret_word_set = Set.new(@secret_word.split(//))
    #retrieves string -> array -> set
    @chosen_letters_set  = Set.new(json_data['chosen_letters_set'])
    @count = json_data['count']
end
    
    