require 'json'
#reads file and stores in memory
$lines = File.readlines("google-10000-english-no-swears.txt")

class Game

def pick_random_line()
    #randomly select a word between 5 and 12 characters long
    selection = $lines[rand($lines.length)]
    if selection.length > 5 && selection.length < 12
      return selection
    else
      pick_random_line()
    end
  end

end

x = Game.new()
puts x.pick_random_line()
puts x.pick_random_line()
puts x.pick_random_line()
puts x.pick_random_line()
puts x.pick_random_line()
puts x.pick_random_line()
puts x.pick_random_line()
puts x.pick_random_line()

