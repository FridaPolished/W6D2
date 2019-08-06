require_relative "PolyTreeNode"

class KnightPathFinder
	attr_reader :origin_pos, :considered_positions

	MOVES =
	[
		[-2, 1],
		[-2, -1],
		[-1, -2],
		[-1, 2],
		[1, 2],
		[1, -2],
		[2, 1],
		[2, -1]
	]

	def initialize(origin)
		@origin = origin
		@considered_positions = [origin]
		@root = PolyTreeNode.new(origin)

		

		build_move_tree
	end


	def self.valid_moves(position)
		proper_moves = []

		x, y = position
		
		MOVES.each do |row, col|
			new_position = [ (x + row), (y + col) ]

			proper_moves << new_position if new_position.all? { |ele| ele.between?(0, 7) }
		end

		proper_moves
  end
  
  def new_move_positions(position)
		moves = KnightPathFinder.valid_moves(position)
		rejected_moves = moves.reject { |ele| considered_positions.include?(ele) }
		rejected_moves.each { |ele| considered_positions << ele } 

	end

	def build_move_tree
		queue = [@root]

		until queue.empty?
			current_node = queue.shift
			current_position = current_node.value

			new_moves = new_move_positions(current_position)

			new_moves.each do |ele|
				temp_node = PolyTreeNode.new(ele)
				current_node.add_child(temp_node)
				queue << temp_node
			end
		end

  end
  
  # traverse the internal data structure (@root) to find the shortest path to any position
  # search for end_position and can use either dfs or bfs search methods
  # should return the tree node instance containing end_position
  def find_path(target)
		ending_position = @root.dfs(target)

		trace_path_back(ending_position)
  end


  # this should trace back from the node given in find_path using PolyTreeNode#parent

  # as it goes up and up toward the root, add each value to an array
  # should return the values in order from start to the end position (reverse?)
  
  def trace_path_back(ending_node)
		return_paths = []

		current_node = ending_node
		until current_node.nil?
			return_paths.unshift(current_node.value)
			current_node = current_node.parent
		end

		return_paths
  end


end

kpf = KnightPathFinder.new( [0,0] )
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
 p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]

