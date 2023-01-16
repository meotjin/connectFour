# frozen_string_literal: true

# instances of board will hold the game board itself and any method logic related to it
class Board
  attr_reader :board, :turn

  def initialize
    # a 2d 8x8 array. each first element of subarrays shows the free space of that column.other numbers are just fillers
    @board = (0..48).each_slice(7).to_a.each { |array| array.unshift(7) }
    @turn = 'Red'
  end

  # extracts all sub 4x4 2d arrays from board and passes them to #check_win?
  def any_winner?
    sub_arrays = get_sub_arrays
    result = false
    sub_arrays.each do |array|
      if check_win? array
        result = true
        break
      end
    end
    result
  end

  def play(row)
    return false if !row.between?(1, 7) || @board[row - 1][0].zero?

    symbol = @turn == 'Red' ? '🔴' : '🟡'
    key = @board[row - 1][0]

    @board[row - 1][8 - key] = symbol
    @board[row - 1][0] -= 1
    turn_over
    true
  end

  private

  # changes the turn
  def turn_over
    @turn = @turn == 'Red' ? 'Yellow' : 'Red'
  end

  # takes a 4x4 array and checks all the win posibilities
  def check_win?(miniboard)
    win_rows?(miniboard) || win_columns?(miniboard) || win_diagonals?(miniboard)
  end

  # takes a 4x4 array to check for row wins
  def win_rows?(miniboard)
    result = false
    4.times do |index|
      array = []
      miniboard.each { |sub_array| array.push(sub_array[index]) }
      if array.uniq.size == 1
        result = true
        break
      end
      break if result
    end
    result
  end

  # takes a 4x4 array to check for column wins
  def win_columns?(miniboard)
    result = false
    4.times do |index|
      if miniboard[index].uniq.size == 1
        result = true
        break
      end
      break if result
    end
    result
  end

  # takes a 4x4 array to check for diagonal wins
  def win_diagonals?(miniboard)
    top_down_diagonal = [miniboard[0][0], miniboard[1][1], miniboard[2][2], miniboard[3][3]]
    down_top_diagonal = [miniboard[3][0], miniboard[2][1], miniboard[1][2], miniboard[0][3]]
    false || top_down_diagonal.uniq.size == 1 || down_top_diagonal.uniq.size == 1
  end

  # extracts a sub 4x4 array from the board
  def sub_array(rows, columns)
    @board[rows].map { |row| row[columns] }
  end

  # return all 4x4 sub arrays
  def get_sub_arrays
    result = []
    4.times do |row_index|
      4.times do |column_index|
        result.push sub_array(0 + row_index..3 + row_index, 1 + column_index..4 + column_index)
      end
    end
    result
  end
end
