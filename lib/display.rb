# frozen_string_literal: true

# displays the board onto command line
class Display
  def self.display(board)
    board = place_holder_remover board
    puts ''
    6.downto(0).each do |index|
      print '|'
      board.each do |array|
        print array[index] + '|'
      end
      puts ''
    end
    puts '----------------------'
  end

  # remove the place holder integers
  def self.place_holder_remover(board)
    board = key_remover(board)
    board.map! do |array|
      array.map! do |place|
        if place.is_a? Integer
          '  '
        else
          place
        end
      end
    end
  end

  # remove the key row from the board , leaving only the game board itself
  def self.key_remover(board)
    board[0..6].map { |row| row[1..7] }
  end
end
