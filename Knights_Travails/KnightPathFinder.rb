require_relative "../poly_tree_node/skeleton/lib/00_tree_node.rb"
require "byebug"

class KnightPathFinder
  attr_reader :root_node

  def self.valid_moves(pos)
    moves = []
    x, y = pos
    moves << [x + 2, y + 1]
    moves << [x + 2, y - 1]
    moves << [x + 1, y + 2]
    moves << [x + 1, y - 2]
    moves << [x - 2, y + 1]
    moves << [x - 2, y - 1]
    moves << [x - 1, y + 2]
    moves << [x - 1, y - 2]

    KnightPathFinder.filter_moves(moves)

  end

  def self.filter_moves(moves)
    moves.reject do |move|
      (move[0] > 7 || move[0] < 0) ||
      (move[1] > 7 || move[1] < 0)
    end
  end

  def initialize(start_pos)
    @root_node = PolyTreeNode.new(start_pos)
    @visited_positions = [start_pos]
    self.build_move_tree
  end

  def build_move_tree
    queue = [@root_node]

    until queue.empty?
      move_pos = queue.shift
      moves = self.new_move_positions(move_pos.value)

      moves.each do |move|
        node = PolyTreeNode.new(move)
        queue << node
        move_pos.add_child(node)
      end
    end
  end

  def find_path(end_pos)
    trace_path_back(self.root_node.bfs(end_pos))
  end

  def trace_path_back(end_node)
    result = [end_node.value]
    prev_node = end_node.parent
    until prev_node.parent.nil?
      result.unshift(prev_node.value)
      prev_node = prev_node.parent
    end
    result.unshift(prev_node.value)
  end

  def new_move_positions(pos)
    new_moves = []
    KnightPathFinder.valid_moves(pos).each do |move|
      new_moves << move unless @visited_positions.include?(move)
    end
    @visited_positions.concat(new_moves)
    new_moves
  end
end
