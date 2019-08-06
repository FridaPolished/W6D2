require_relative 'tic_tac_toe_node'
require "byebug"

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
    current_node = TicTacToeNode.new(game.board, mark)
    children = current_node.children 
    children2 = current_node.children.dup
    children.each do |child|
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end

    #debugger
    children2.each do |child|
      if !child.losing_node?(mark)
        return child.prev_move_pos
      end 
    end
   
    raise "Error! there are no losing moves!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
