require_relative 'player'
require_relative 'monster'

class Game

  attr_accessor :playing

  def initialize
    @playing = true
    start_game
    game_loop
    #call method to start game
  end
  def start_game
    puts "You wake up in a daze. You look around. You are in the big workspace. No on is around. No sound is heard, except for a faint whisper-- 'call your moommmmm'. How are you feeling?"
    answer = gets.chomp
    puts "Oh yeah? You're feeling #{answer}? That's nice. Not that I care."
    puts "Anyways, what's your name?"
    name = gets.chomp
    @player = Player.new(name)
    puts "Welcome to Turing Apocalypse, #{@player.name}"
  end

  def game_loop
    while playing
      puts "You think to yourself, this is creepy. Perhaps I will look around. Where should we go?"
      location = gets.chomp
      case location.downcase
        when "classroom c"
          classroom_c
        when "classroom b"
        when "kitchen"
        when "bathroom"
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
    response = gets.chomp
    if response.downcase == "run away"
      puts "As you turn your back, the chain wraps around your neck and tightens. #{chaimz.name} laughs and yells, 'Face your fears to live your dreams!' as your breathe your last breath."
      @player.health = 0
      @playing = false
    else
      fight(chaimz)
    end
  end

  def fight(monster)
    until monster.health <= 0 || @player.health <= 0
      puts "You take a swing with your sword that appeared magically."
      monster.health -= rand(1..10) #how many hp are taken with each swing, let player decide when to take swings
      puts "#{monster.name} retaliates!"
      @player.health -= rand(1..5)
    end
  end

end

game = Game.new
