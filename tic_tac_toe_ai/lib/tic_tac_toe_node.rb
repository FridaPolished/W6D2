require_relative 'tic_tac_toe'
require "byebug"


class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  # basecase BOARD over && 
  # If winner is the opponent, this is a losing node.
  # If winner is nil or us, this is not a losing node.

  #recursive case
  # It is the player's turn, and all the children nodes are losers for 
  # the player (anywhere they move they still lose), OR

  #It is the opponent's turn, and one of the children nodes is a losing node 
  #for the player (assumes your opponent plays perfectly; they'll force you to lose if they can).
  def losing_node?(evaluator)#mark
    if @board.over?
      return false if evaluator == @board.winner
      return false if @board.tied? == true
      return true

      #If winner is the opponent, this is a losing node.
      #If winner is nil or us, this is not a losing node.
      #Note:
      #NB: a draw (Board#tied?) is NOT a loss, 
      #if a node is a draw, losing_node? should return false.
    elsif next_mover_mark != evaluator
      self.children.any? do |child|
        child.losing_node?(evaluator)
      end
    else
      self.children.all? do |child|
        child.losing_node?(evaluator)
      end
    end
  end
  
  
  def winning_node?(evaluator)
    if @board.over?
      return true if evaluator == @board.winner
      return false
    elsif next_mover_mark == evaluator
      self.children.any? do |child|
        child.winning_node?(evaluator)
      end
    else
      self.children.all? do |child|
        child.winning_node?(evaluator)
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children2 = []
    length = @board.rows.length

    (0...length).each do |x|
      (0...length).each do |y|
        position = [x, y]
        if @board[position].nil?
          temp_board = @board.dup
          temp_board[position] = @next_mover_mark
          if @next_mover_mark == :x
            temp_mark = :o
          else
            temp_mark = :x
          end
        children2 << TicTacToeNode.new(temp_board, temp_mark, position)
        end
      end
    end
    children2
  end  
end
