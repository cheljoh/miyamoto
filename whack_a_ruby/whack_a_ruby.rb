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
  end

  def draw
    @image.draw((@x - @width / 2), (@y - @height / 2), 1) #first arg is how many pixels you want from left edge, second is top
  end

  def update
    
  end


end

window = WhackARuby.new
window.show
