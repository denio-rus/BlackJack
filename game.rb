class Game
  attr_reader :player, :dealer, :interface, :screen

  def initialize
    @interface = Interface.new
    name = interface.request_name
    @player = Player.new(name)
    @screen = {}
  rescue RuntimeError => e
    interface.error(e)
    retry
  end

  def play
    loop do
      input = interface.request_game(player.name)
      if input == 'y'
        start_game
      else
        exit
      end
      interface.end_game(winner) if winner?
    end
  end

  private

  attr_accessor :player_hand, :dealer_hand, :deck, :bank
  attr_writer :player, :dealer

  def start_game
    self.dealer = Dealer.new
    self.bank = Bank.new
    screen['player'] = player.name
    screen['dealer'] = dealer.name
    loop do
      start_round
      round_winner = play_round
      interface.round_end(round_winner)
      break if winner?
      input = interface.request_continue
      break if input == 'n'
    end
  end

  def start_round
    bank.bet
    self.deck = Deck.new
    card1 = deck.give_card
    card2 = deck.give_card
    self.player_hand = Hand.new(card1, card2)
    card1 = deck.give_card
    card2 = deck.give_card
    self.dealer_hand = DealerHand.new(card1, card2)
    screen['player_money'] = bank.player_money
    screen['dealer_money'] = bank.dealer_money
    screen['bank'] = bank.game_bank
  end

  def play_round
    loop do
      screen['player_hand'] = player_hand.show_cards
      screen['dealer_hand'] = dealer_hand.show_cards_face_down
      screen['player_points'] = player_hand.total_points
      screen['dealer_points'] = '???'
      interface.card_table(screen)
      case interface.round_menu
      when 1
        dealer_move
      when 2
        if player_hand.cards_number == 3
          interface.card_limit
        else
          take_card
          return open_card if player_hand.total_points > 21
          dealer_move
        end
      when 3
        return open_card
      end
      return open_card if player_hand.cards_number == 3 && dealer_hand.cards_number == 3
    end
  end

  def dealer_move
    dealer_move = dealer.make_decision(dealer_hand)
    if dealer_move == 'take'
      card = deck.give_card
      dealer_hand.take(card)
      interface.comment(dealer.name, :take)
    else
      interface.comment(dealer.name, :pass)
    end
  end

  def take_card
    player_hand.take(deck.give_card)
    screen['player_hand'] = player_hand.show_cards
    screen['player_points'] = player_hand.total_points
    interface.card_table(screen)
  end

  def winner?
    !!winner
  end

  def winner
    return player.name if bank.dealer_money.zero?
    dealer.name if bank.player_money.zero?
  end

  def open_card
    screen['dealer_hand'] = dealer_hand.show_cards
    screen['dealer_points'] = dealer_hand.total_points
    interface.card_table(screen)
    player_result = player_hand.total_points
    dealer_result = dealer_hand.total_points
    if player_result > 21 || dealer_result > player_result && dealer_result <= 21
      bank.dealer_win
      return dealer.name
    elsif player_result > dealer_result || dealer_result > 21
      bank.player_win
      return player.name
    else
      bank.draw
      return
    end
  end
end
