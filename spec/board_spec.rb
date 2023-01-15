# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#win_rows?' do
    subject(:my_board) { described_class.new }
    context 'when there is no 4 in row' do
      it 'returns false' do
        result = my_board.win_rows?
        expect(result).to be_win_rows
      end
    end
  end
end
