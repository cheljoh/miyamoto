require 'gosu'
# require_relative '../WhackARuby_starter.ruby'

class WhackARuby < Gosu::Window

  def initialize
    super(800, 600)
    self.caption = "Whack-A-Ruby!"
    @image = Gosu::Image.new('ruby.png')
    @x = 200
    @y = 200
    #starting position
    @width = 50
    @height = 43
    @velocity_x = 5
    @velocity_y = 5
    #how fast it moves in each direction
    @visible = 0
    @hammer_image = Gosu::Image.new('hammer.png')
    @hit = 0
    @font = Gosu::Font.new(30)
    @score = 0
    @playing = true
    @start_time = 0

    @second_ruby = Gosu::Image.new('ruby.png')
    @second_x = 400
    @second_y = 400
    @second_width = 50
    @second_height = 43
    @second_velocity_x = 5
    @second_velocity_y = 5

  end

  def draw
    if @visible > 0
      @image.draw(@x - @width / 2, @y - @height / 2, 1)
      #draws the image
    end
    @hammer_image.draw(mouse_x - 40, mouse_y - 10, 1)
    if @hit == 0
      c = Gosu::Color::NONE
    elsif @hit == 1
      c = Gosu::Color::GREEN
    elsif @hit == -1
      c = Gosu::Color::RED
    end
    draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
    @hit = 0
    @font.draw(@score.to_s, 700, 20, 2)
    @font.draw(@time_left.to_s, 20, 20, 2)
    unless @playing
      @font.draw('Game Over!', 300, 300, 3)
      @font.draw('Press SPACE to Play Again', 210, 350, 3)
      @visible = 20
    end
  end

  def update
    if @playing
      @x += @velocity_x
      @y += @velocity_y
      #moves the image
      @visible -= 1
      @time_left = (20 - ((Gosu.milliseconds - @start_time) / 1000))
      @playing = false if @time_left < 0
      @velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0
      @velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 0
      #allows the image to bounce around instead of disappearing off the screen
      @visible = 30 if @visible < -10 && rand < 100
    end
  end

  def button_down(id)
    if @playing
      if (id == Gosu::MsLeft)
        if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible >= 0
          @hit = 1
          @score += 5
        else
          @hit = -1
          @score -= 1
        end
      end
    else
      if (id == Gosu::KbSpace)
        @playing = true
        @visible = -10
        @start_time = Gosu.milliseconds
        @score = 0
      end
    end
  end
end

window = WhackARuby.new
window.show
