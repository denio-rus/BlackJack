class Interface
  include Messages

  def request_name
    request_name_message
    gets.chomp.capitalize
  end

  def request_game(name)
    loop do
      request_game_message(name)
      input = gets.chomp.downcase
      return input if %w[y n].include?(input)
      wrong_choise_message
    end
  end

  def request_continue
    loop do
      request_continue_message
      input = gets.chomp.downcase
      return input if %w[y n].include?(input)
      wrong_choise_message
    end
  end

  def card_table(screen)
    cards_table_message(screen)
  end

  def round_menu
    loop do
      round_menu_message
      input = gets.to_i
      return input if [1, 2, 3].include?(input)
      wrong_choise_message
    end
  end

  def round_end(round_winner)
    round_end_message(round_winner)
  end

  def end_game(winner)
    result_message(winner)
  end

  def error(e)
    error_message(e)
  end

  def card_limit
    card_limit_message
  end

  def comment(who, move)
    comment_message(who, move)
  end
end
