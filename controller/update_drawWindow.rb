require 'rubygems'
require 'gosu'

class MyWindow < Gosu::Window
	WIDTH = 640
	HEIGHT = 480
	TITLE = "My Gosu Window"

TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

def initialize
	super(WIDTH, HEIGHT, false)
	self.caption = TRUE
end

def update
	@last_frame = 0 
	calculate_delta
end

def calculate_delta
	@this_frame = Gosu::milliseconds
	@delta = (@this_frame - @last_frame) / 1000.0
	@last_frame = @this_frame
end


def draw
	draw_background
end

def draw_background
	draw_quad(
		0,	0,	TOP_COLOR,
		WIDTH,	0,	TOP_COLOR,
		0,	HEIGHT,	BOTTOM_COLOR,
		WIDTH,	HEIGHT,	BOTTOM_COLOR,
		0)
	end
end

MyWindow.new.show
