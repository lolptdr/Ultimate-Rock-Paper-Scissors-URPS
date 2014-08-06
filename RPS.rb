class RPS
  attr_reader :player1, :player2, :player1win, :player2win, :total
  def initialize (player1, player2)
    @player1 = player1
    @player2 = player2
    @total = 0
  end

  def play (move1, move2)
    move1 = move1.downcase
    move2 = move2.downcase
    raise :error if move1 != "rock" || move1 != "paper" || move1 != "scissors"
    raise :error if move2 != "rock" || move2 != "paper" || move2 != "scissors"
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
  end
end


require 'io/console'
class RPSPlayer
  def self.start
    p1_wins = 0
    p2_wins = 0
    puts "Player 1 Name: "
    player1 = gets.chomp
    puts "Player 2 Name: "
    player2 = gets.chomp
    rps_game = RPS.new(player1, player2)    


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