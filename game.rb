require './question'
require './player'

class Game
  attr_accessor :number_of_turns, :current_turn

  def initialize(number_of_turns = 3, players = 1)
    @number_of_turns = number_of_turns
    players.times { |i| Player.new(i + 1) }
    @players = Player.players?.cycle
    @current_player = @players.next
    @current_turn = 1
    end

  def play
    start_number_of_turns = @number_of_turns
    puts '----- GAME STARTS -----'
    puts "PLAYERS: #{Player.players?.length}"
    while @number_of_turns > 0 && @current_player.lives > 0
      puts "TURN #{@current_turn}/#{start_number_of_turns}"
      puts "Player #{@current_player.player_number}:"
      get_input?
      @current_player = @players.next
      if @number_of_turns != 0 
        puts "---------------" 
      end 
    end
    puts '----- GAME OVER -----'
    get_scores?
  end

  private 

  def get_scores?
    players = Player.players?.sort_by(&:score).reverse
    players[0].score > 0 && Player.players?.length > 1 ? (puts "Player #{players[0].player_number} WINS!") : (puts "You scored: #{players[0].score}")
    puts '----- RANKINGS -----'
    players.each do |player|
      puts "Player #{player.player_number} Score: #{player.score} Lives: #{player.lives}/3"
    end
  end

  def random_number
    rand(1..100)
  end

  def get_question?
    Question.new(random_number, random_number)
  end

  def get_input?
    question = get_question?
    input = ''
    loop do
      input = gets.chomp
      if input.match(/\d/)
        break
      elsif input == 'q'
        puts 'Goodbye'
        exit(0)
      end
      puts 'You did not enter a number, try again or enter q to quit'
    end
    if input.to_i == question.answer
      puts 'YES! You are correct.'
      @current_player.increase_score!
    else
      puts 'No! You are incorrect.'
      @current_player.decrease_player_life!
    end
    if @current_player.player_number == Player.players?.length
      @number_of_turns -= 1
      @current_turn += 1
    end
  end
end
