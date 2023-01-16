# frozen_string_literal: true

require_relative 'board'
require_relative 'display'
require 'colorize'
require 'io/console'

# plays the game!
class Game
  def initialize
    @board = Board.new
  end

  def intro
    system('clear')
    puts 'Welcome To Connect Four!'.blue
    puts "\nthe rules are simple:  connect 4 of your pieces horizontally, vertically or diagonale!"
    puts "\nplayer #1 is #{'Red'.red} and player #2 is #{'Yellow'.yellow}!"
    puts "\nnow now... press F to pay res... no no any key to continue!"
    STDIN.getch
    gameplay
  end

  def gameplay
    system 'clear'
    Display.display @board.board
    puts "#{@board.turn.yellow} plz enter a valid number between 1-7 in a not-filled column to play your turn!"
    input = gets.chomp
    @board.play(input.to_i)
    if @board.any_winner?
      anounce_winner
      return
    end

    gameplay
  end

  def anounce_winner
    system 'clear'
    puts "\n We Have a Winner!".yellow

    Display.display @board.board

    puts 'Congrats!'
  end
end
