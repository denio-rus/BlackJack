require_relative 'card.rb'

class Deck
  NOMINAL = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUIT = %w[<> ^ <3 +].freeze
  def self.all_cards
    SUIT.product(NOMINAL)
  end

  def initialize
    @deck = []
    self.class.all_cards.each do |parameters|
      @deck << Card.new(parameters[1], parameters[0])
    end
    @deck.shuffle!
  end

  def give_card
    deck.shift
  end

  private

  attr_reader :deck
end
