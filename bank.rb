class Bank
  attr_reader :game_bank, :player_money, :dealer_money

  def initialize
    @player_money = 100
    @dealer_money = 100
    @bet_size = 10
    @game_bank = 0
  end

  def bet
    self.player_money -= bet_size
    self.dealer_money -= bet_size
    self.game_bank = 2 * bet_size
  end

  def player_win
    self.player_money += game_bank
    self.game_bank = 0
  end

  def dealer_win
    self.dealer_money += game_bank
    self.game_bank = 0
  end

  def draw
    self.dealer_money += bet_size
    self.player_money += bet_size
    self.game_bank = 0
  end

  private

  attr_reader :bet_size
  attr_writer :game_bank, :player_money, :dealer_money
end
