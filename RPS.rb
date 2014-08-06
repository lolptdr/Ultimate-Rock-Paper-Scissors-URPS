class RPS
  # Rock, Paper, Scissors
  # Make a 2-player game of rock paper scissors. It should have the following:
  #
  # It is initialized with two strings (player names).
  # It has a `play` method that takes two strings:
  #   - Each string reperesents a player's move (rock, paper, or scissors)
  #   - The method returns the winner (player one or player two)
  #   - If the game is over, it returns a string stating that the game is already over
  # It ends after a player wins 2 of 3 games
  #
  # You will be using this class in the following class, which will let players play
  # RPS through the terminal.
  attr_reader :player1, :player2, :player1win, :player2win, :total
  def initialize (player1, player2)
    @player1 = player1
    @player2 = player2
    # @player1win = 0
    # @player2win = 0
    @total = 0
  end

  def play (move1, move2)
    move1 = move1.downcase
    move2 = move2.downcase
    # raise :error if move1 != "rock" || move1 != "paper" || move1 != "scissors"
    # raise :error if move2 != "rock" || move2 != "paper" || move2 != "scissors"
    if move1 == 'rock' && move2 == 'paper'
      return :player2
    elsif move1 == 'rock' && move2 == 'scissors'
      return :player1
    elsif move1 == 'paper' && move2 == 'rock'
      return :player1
    elsif move1 == 'paper' && move2 == 'scissors'
      return :player2
    elsif move1 == 'scissors' && move2 == 'rock'
      return :player2
    elsif move1 == 'scissors' && move2 == 'paper'
      return :player1
    else
      return :tie
    end

    # @total += 1

    # if @total >= 3 and player1win >=2
    #   puts player1 + " wins the game"
    #   @player1win = 0
    #   @player2win = 0
    #   @total = 0
    # elsif @total >=3 and player2win >=2
    #   puts player2 + " wins the game"
    #   @player1win = 0
    #   @player2win = 0
    #   @total = 0
    # elsif @total == 2 and player1win == 2
    #   puts player1 + " wins the game"
    #   @player1win = 0
    #   @player2win = 0
    #   @total = 0
    # elsif @total == 2 and player2win == 2
    #   puts player2 + " wins the game"
    #   @player1win = 0
    #   @player2win = 0
    #   @total = 0
    # end
  end
end

# Nick's solution:

# Class RPS
#   @beats = {
#     rock: :paper,
#     paper: :scissors,
#     scissors: :rock
#   }

#   def play p1, p2
#     if p1 == @beats[p2]
#       puts "p1 wins"
#     elsif p2 == @beats[p1]
#       puts "p2 wins"
#     else
#       puts "tie"
#     end
#   end

# end


require 'io/console'
class RPSPlayer
  # (No specs are required for RPSPlayer)
  #
  # Complete the `start` method so that it uses your RPS class to present
  # and play a game through the terminal.
  #
  # The first step is to read (gets) the two player names. Feed these into
  # a new instance of your RPS class. Then `puts` and `gets` in a loop that
  # lets both players play the game.
  #
  # When the game ends, ask if the player wants to play again.

  def self.start
    p1_wins = 0
    p2_wins = 0
    puts "Player 1 Name: "
    player1 = gets.chomp
    puts "Player 2 Name: "
    player2 = gets.chomp
    rps_game = RPS.new(player1, player2)    
    # PRO TIP: Instead of using plain `gets` for grabbing a player's
    #          move, this line does the same thing but does NOT show
    #          what the player is typing! :D
    # This is also why we needed to require 'io/console'
    # move = STDIN.noecho(&:gets)


    while (true)
      puts "Player 1 Move: "
      move1 = STDIN.noecho(&:gets).chomp
      puts "Player 2 Move: "
      move2 = STDIN.noecho(&:gets).chomp
      rps_game.play(move1, move2)

      winner = rps_game.play(move1, move2)

      if winner == :player1
        puts "#{player1} wins!"
        p1_wins += 1
      elsif winner == :player2
        puts "#{player2} wins!"
        p2_wins += 1
      else
        puts "tie"
      end

      break if p1_wins == 2 || p2_wins == 2
    end
  end
end

# This is a test comment