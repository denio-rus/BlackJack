class Hand
  attr_reader :hand

  def initialize(card1, card2)
    @hand = [card1, card2]
  end

  def show_cards
    show = []
    hand.each { |card| show << "#{card.nominal}#{card.suit}" }
    show.join('|')
  end

  def cards_number
    hand.size
  end

  def take(card)
    @hand << card
  end

  def total_points
    total_points = []
    hand.each { |card| total_points << card.points }
    aces = total_points.count(11)
    return 13 if aces == 3

    sum = 0
    without_aces = total_points - [11]
    without_aces.each { |points| sum += points }
    return sum if aces.zero?

    if aces == 2 && sum == 10
      sum = 12
    elsif aces == 2 && sum < 10
      sum += 12
    elsif aces == 1 && sum + 11 > 21
      sum += 1
    else
      sum += 11
    end
    sum
  end
end
