class Dealer
  attr_reader :name

  def initialize
    nickname = ['One-eyed', 'Four fingers', 'Godzilla', 'KGB', 'Diablo'].sample
    name = ['Joe', 'Vinny', 'Franky', 'Mary', 'Granny Bo', 'Boris', 'Jesus'].sample
    @name = "#{name} - #{nickname}"
  end

  def make_decision(dealer_hand)
    'take' if dealer_hand.total_points < 17
  end
end
