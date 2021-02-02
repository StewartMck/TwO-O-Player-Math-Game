class Player
  @@players = []

  attr_reader :lives, :player_number, :score

  def initialize(player_number)
    @lives = 3
    @player_number = player_number
    @score = 0
    @@players.push(self)
  end

  public

  def decrease_player_life!
    @lives -= 1
  end

  def increase_score!
    @score += 1
  end

  def self.players?
    @@players
  end
end
