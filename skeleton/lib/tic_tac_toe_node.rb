require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    board.over? && 
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []
    board.each_with_index do |row, idx|
      row.each_index do |idx2|
        if board[idx][idx2] == nil
          result << [idx, idx2]
          new_board = board.dup
          new_board[idx][idx2] = next_mover_mark
          next_mover_mark == ':x' ? next_mover_mark = ':o' : next_mover_mark = ':x'
          child = TicTacToeNode.new(new_bard, next_mover_mark, [idx, idx2])
        end
      end
    end
    result
  end
end
