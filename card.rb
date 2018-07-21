class Card
  attr_reader :nominal, :suit, :points

  def initialize(nominal, suit)
    @nominal = nominal
    @suit = suit
    @points = set_points
  end

  private

  def set_points
    if @nominal.to_i > 0
      @nominal.to_i
    elsif %w[J Q K].include?(@nominal)
      10
    else
      11
    end
  end
end
