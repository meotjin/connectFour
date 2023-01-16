# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:my_board) { described_class.new }
  describe '#win_rows?' do
    context 'when there is no 4 in row' do
      let(:array) do
        [
          [1, 1, 1, 1],
          [2, 2, 2, 2],
          [3, 3, 3, 3],
          [4, 4, 4, 4]
        ]
      end
      it 'returns false' do
        result = my_board.send(:win_rows?, array)
        expect(result).to be false
      end
    end
    context 'when the is 4 in row' do
      let(:array) do
        [
          [1, 1, 3, 1],
          [2, 2, 3, 2],
          [3, 3, 3, 3],
          [4, 4, 3, 4]
        ]
      end
      it 'returns true' do
        result = my_board.send(:win_rows?, array)
        expect(result).to be true
      end
    end
  end

  describe '#win_columns?' do
    context 'when there is no 4 in column' do
      let(:array) do
        [
          [1, 2, 3, 4],
          [1, 2, 3, 4],
          [1, 2, 3, 4],
          [1, 2, 3, 4]
        ]
      end
      it 'returns false' do
        result = my_board.send(:win_columns?, array)
        expect(result).to be false
      end
    end
    context 'when there is 4 in column' do
      let(:array) do
        [
          [1, 2, 3, 4],
          [1, 2, 3, 4],
          [1, 2, 3, 4],
          [4, 4, 4, 4]
        ]
      end
      it 'returns true' do
        result = my_board.send(:win_columns?, array)
        expect(result).to be true
      end
    end
  end

  describe '#win_diagonals?' do
    context 'when there is no 4 in diagonal' do
      let(:array) do
        [
          [1, 2, 3, 4],
          [1, 2, 3, 4],
          [1, 2, 3, 4],
          [1, 2, 3, 4]
        ]
      end
      it 'returns false' do
        result = my_board.send(:win_diagonals?, array)
        expect(result).to be false
      end
    end
    context 'when there is 4 in diagonal' do
      context 'in top_down diagonal' do
        let(:array) do
          [
            [1, 2, 3, 4],
            [1, 1, 3, 4],
            [1, 2, 1, 4],
            [1, 2, 3, 1]
          ]
        end
        it 'returns true' do
          result = my_board.send(:win_diagonals?, array)
          expect(result).to be true
        end
      end
      context 'in down_top diagonal' do
        let(:array) do
          [
            [1, 2, 3, 1],
            [1, 2, 1, 4],
            [1, 1, 3, 4],
            [1, 2, 3, 4]
          ]
        end
        it 'returns true' do
          result = my_board.send(:win_diagonals?, array)
          expect(result).to be true
        end
      end
    end
  end

  describe '#check_win?' do
    context 'when there is no win' do
      let(:array) do
        [
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 10, 11, 12],
          [13, 14, 15, 16]
        ]
      end
      it 'returns false' do
        result = my_board.send(:check_win?, array)
        expect(result).to be false
      end
    end
    context 'when there is win' do
      context 'when there is win in a row' do
        let(:array) do
          [
            [1, 2, 3, 4],
            [1, 6, 7, 8],
            [1, 9, 11, 12],
            [1, 14, 15, 16]
          ]
        end
        it 'returns true' do
          result = my_board.send(:check_win?, array)
          expect(result).to be true
        end
      end
      context 'when there is win in column' do
        let(:array) do
          [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [8, 8, 8, 8],
            [13, 14, 15, 16]
          ]
        end
        it 'returns true' do
          result = my_board.send(:check_win?, array)
          expect(result).to be true
        end
      end
      context 'when there is win in diagonal' do
        let(:array) do
          [
            [16, 2, 3, 4],
            [5, 16, 7, 8],
            [9, 10, 16, 12],
            [13, 14, 15, 16]
          ]
        end
        it 'returns true' do
          result = my_board.send(:check_win?, array)
          expect(result).to be true
        end
      end
    end
  end

  describe '#sub_array' do
    it 'returns a sub array using given arguments' do
      sub_array = my_board.send(:sub_array, 0..3, 1..4)
      prediction = [
        [0, 1, 2, 3],
        [7, 8, 9, 10],
        [14, 15, 16, 17],
        [21, 22, 23, 24]
      ]
      expect(sub_array).to eq(prediction)
    end
  end

  describe '#play' do
    it 'places a 🔴 in 4th row' do
      my_board.play(4)
      expect(my_board.board[3][1]).to eq('🔴')
    end

    it 'places a 🟡 in 4th row after the first turn' do
      my_board.play 4
      my_board.play(4)
      expect(my_board.board[3][2]).to eq('🟡')
    end
  end

  describe '#any_winner?' do
    context 'when there is no winner' do
      it 'returns false' do
        expect(my_board.any_winner?).to be false
      end
    end
    context 'when there is winner' do
      it 'returns true' do
        my_board.play 1
        my_board.play 1
        my_board.play 2
        my_board.play 2
        my_board.play 3
        my_board.play 3
        my_board.play 4
        expect(my_board.any_winner?).to be true
      end
    end
  end
end
