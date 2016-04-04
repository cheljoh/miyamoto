require 'gosu'

class WhackARuby < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Whack the Ruby!'
    @image = Gosu::Image.new('cat_image.png')
    @x = 300
    @y = 300
    @width = 256
    @height= 256
    @velocity_x = 5
    @velocity_y = 5
    @visible = 0
  end

  def draw
    if @visible > 0
      @image.draw((@x - @width / 2), (@y - @height / 2), 1) #first arg is how many pixels you want from left edge, second is top
    end
  end

  def update
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0 #this will make sure it doesn't go off the screen in x plane
    @velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 0 #makes sure it doesn't go off screen in y plane
    @visible -= 1 #this makes it blink
    @visible = 30 if @visible < -10 && rand < 0.01
  end


end

window = WhackARuby.new
window.show
