require 'gosu'

module ZOrder
	Background, Stars, Player, UI = *0..3
end

class  Player 
	def initialize(window)
		@image = Gosu::Image.new(window, "../media/metroid_block.png", false)
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@score =0
	end

	def warp(x,y)
		@x, @y =x , y
	end

	def turn_left
		@angle -= 4.5
	end
	
	def turn_right
		@angle += 4.5
	end

	def accelerate 
		@vel_x += Gosu::offset_x(@angle, 0.5)
		@vel_y += Gosu::offset_y(@angle, 0.5)
	end

	def move
		@x += @vel_x
		@y += @vel_y
		@x %= 640
		@y %= 480
		
		@vel_x *= 0.95
		@vel_y *= 0.95
	end

	def draw
		@image.draw_rot(@x, @y, 1, @angle)
	end
end

class Star
	attr_reader:x, :y
	
	def initialize(animation)
		@animation = animation
		@color = Gosu::Color.new(0xff000000)
		@color.red = rand(255 - 40) + 40
		@color.green = rand(255 - 40) + 40
		@color.blue = rand(256 - 40) + 40
		@x = rand * 640
		@y = rand * 480
	end
	
	def draw
		img = @animation[Gosu::milliseconds / 100 % @animation.size];
		img.draw(@x - img.width / 2.0, @y - img.height /2.0)
			ZOrder::Stars, 1, 1, @color, :add)
	end
end


class GameWindow < Gosu::Window
	def initialize
		super 640, 480,  false
		self.caption = "Explode Quest"
	
		@background_image = Gosu::Image.new(self, "../media/whitecircle.png", true)
		
		@player = Player.new(self)
		@player.warp(320, 240)
	end

	def update
		if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
			@player.turn_left
		end
		if button_down? Gosu::KbRight or button_down? Gosu::GpRight then 
			@player.turn_right
		end
		if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
			@player.accelerate
		end
		@player.move
	end
	
	def draw
		@player.draw
		@background_image.draw(0,0,0)
	end

	def button_down(id)
		if id == Gosu::KbEscape
			close
		end
	end
end

window = GameWindow.new
window.show
