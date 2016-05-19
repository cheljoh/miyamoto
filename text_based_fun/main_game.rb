require_relative 'player'
require_relative 'monster'
require_relative 'whack_a_ruby/whack_a_ruby'

class Game

  attr_accessor :playing

  def initialize
    @playing = true
    start_game
    game_loop
  end

  def getAnswer
    gets.chomp
  end

  def start_game
    message = "You wake up in a daze. You look around. You are in the big workspace. No one is around. No sound is heard, except for a faint whisper--"
    call_your_mom = "'call your mom'."
    the_feels = "How are you feeling?"
    say("Princess", message)
    say("Whisper", call_your_mom)
    puts message
    puts call_your_mom
    puts the_feels
    answer = getAnswer
    puts "Oh yeah? You're feeling #{answer}? That's nice. Not that I care."
    puts "Anyways, what's your name?"
    name = getAnswer
    @player = Player.new(name)
    puts "Welcome to Turing Apocalypse, #{@player.name}."
    puts skull
    puts "You think to yourself, this is creepy. Perhaps I will look around."
  end

  def skull
  "    .-'''-.
   | _   _ |
   ](_' `_)[
   `-. N ,-'
     |   |
     `---' "
  end

  def game_loop
    while playing
      puts "Where should we go?"
      puts map
      location = getAnswer
      case location.downcase
        when "classroom c"
          classroom_c
        when "classroom b"
          classroom_b
        when "kitchen"
        when "bathroom"
          bathroom
        when "hallway"
        else
          puts "You can't go there!"
      end
    end
  end

  def classroom_c
    puts "It's dark and smelly in classroom c. You hear the sound of a heavy chain dragging across the wooden desks."
    chaimz = Monster.new("Chaimzzzz", 20)
    puts "From the darkness emerges a huge figure wrapped in chains. He also happens to be wearing a fashionable beanie."
    puts "He says, 'Feel the wrath of #{chaimz.name}!' He whips a chain towards you."
    puts "What will you do? Run away or fight?"
    response = getAnswer
    if response.downcase == "run away"
      message = "You must face your fears to live your dreams today!"
      puts "As you turn your back, the chain wraps around your neck and tightens. #{chaimz.name} laughs and as you breathe your last breath, he yells, #{message}"
      say("bad news", message)
      kill_player
    else
      fight(chaimz)
    end
    if !player_dead?
      riddle_preface = "with his dying breath, #{chaimz.name} whispers a riddle:"
      puts riddle_preface
      riddle = "take off my skin I wont cry, but you will! What am I?"
      answer = "onion"
      secret_key = "39"
      riddle_game(riddle, answer, secret_key)
    end
  end

  def classroom_b
    puts "You enter classroom b and you are greeted with luscious greenery and a sweet smell of nature."
    puts "A curious creature emerges, and greets you"
    puts "One of the unicorn heads then says 'Mah naem ish Andeerw'"
    puts "The other one says, 'please stop singing happy birthday. While you're at it, don't forget to sign up for an elective."
    puts "'Hello, #{@player.name}. Would you like some opulent unicorn secretions?', asks the two headed unicorn."
    bicorn = Monster.new("Randrewcorn", 40)
    answer = getAnswer
    if answer.downcase == "yes"
      change_health
      puts "You gained #{change_health} health, your current health is #{@player.health}."
    else
      puts "You suck, wheres that ascii finger?"
      @player.health -= change_health
      puts "Because you're a dick, you lost #{change_health}, and your health is now #{@player.health}."
      fight(bicorn)
      if !player_dead?
        riddle_preface = "with his dying breath, #{bicorn.name} whispers a riddle:"
        riddle = "Tear one off and scratch my head what was red is black instead"
        puts riddle_preface
        answer = "match"
        secret_key = "42"
        riddle_game(riddle, answer, secret_key)
      end
    end
  end

  def bathroom
    puts "You see three doors in the bathroom hallway. Which one do you choose door 1, 2 or 3?"
    answer = getAnswer
    if answer == "1"
      change_health
      puts "You gained #{change_health} health, Your health is now #{@player.health}"
    elsif answer == "2"
      kill_player
      puts "Wrong choice!"
    elsif answer == "3"
      window = WhackARuby.new
      window.show
    else
      "Pschhh try again"
    end
  end

  def change_health
    @player.health += rand(5..20)
  end

  def fight(monster)
    until monster_dead?(monster) || player_dead?
      puts "You take a swing with your sword that appeared magically."
      player_hit = rand(1..10)
      monster.health -= player_hit #how many hp are taken with each swing, let player decide when to take swings
      puts "#{monster.name} takes #{player_hit} damage"
      puts "#{monster.name} retaliates!"
      monster_hit = rand(1..5)
      @player.health -= monster_hit
      puts "You take #{monster_hit} damage"
      puts "Your current health is #{@player.health}. #{monster.name}'s health is #{monster.health}"
      unless monster_dead?(monster)
        puts "swing again?"
        answer = getAnswer
      end
      if answer.downcase == "no"
        kill_player
      end
    end
    if monster_dead?(monster)
      puts "You killed the #{monster.name}"
    else
      puts "You died"
      kill_player
    end
  end

  def monster_dead?(monster)
    monster.health <= 0
  end

  def player_dead?
    @player.health <= 0
  end

  def kill_player
    @player.health = 0
    @playing = false
    puts "You died"
  end

  def riddle_game(riddle, answer, secret_key)
    say("bad news", riddle)
    puts riddle
    riddle_answer = getAnswer
    correct = false
    until correct
      if riddle_answer.downcase.include?(answer)
        puts "You guessed correctly. The secret key is #{secret_key}."
        correct = true
      elsif riddle_answer.downcase == "i don't know"
        puts "You weakling. You deserve death."
        kill_player
      else
        puts "WRONG. Guess again you noob"
        riddle_answer = getAnswer
      end
    end
  end

  def say(narrator, message)
    `say -v #{narrator} #{message}`
  end


  def map
    "
  ||========================================================||
  ||        |                                               ||
  ||bathroom                  hallway                       ||
  ||--------|------------------     --------    -------   --||
  ||kitchen                |            |           |       ||
  ||                                    |           |       ||
  ||                       |classroom b |classroom a| staff ||
  ||        big workspace  |            |           |       ||
  ||                       |            |           |       ||
  ||--   -------------   --|            |-----------|       ||
  ||classroom c            |            |                   ||
  ||                       |            |  horace's lair    ||
  ||========================================================||"
  end

end

game = Game.new
