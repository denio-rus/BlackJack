module Messages
  COMMENTS = { take: 'берет еще одну карту', pass: 'пассует, пропуская ход' }.freeze

  def request_name_message
    print 'Введите Ваше имя: '
  end

  def request_game_message(name)
    print "Приветствую, #{name}! Желаете начать новую игру? (y/n): "
  end

  def request_continue_message
    print 'Продолжите играть? (y/n): '
  end

  def wrong_choise_message
    puts 'Некорректный ввод'
  end

  def error_message(e)
    puts e
  end

  def round_menu_message
    puts '1. Пасс'
    puts '2. Взять карту'
    puts '3. открыть карты'
    print 'Ваш выбор: '
  end

  def cards_table_message(screen)
    puts "#{screen['player']} money:$#{screen['player_money']} cards:#{screen['player_hand']} points:#{screen['player_points']} "\
          "---$bank:#{screen['bank']}$--- points:#{screen['dealer_points']} cards:#{screen['dealer_hand']} money:"\
          "$#{screen['dealer_money']} dealer: #{screen['dealer']}"
  end

  def round_end_message(round_winner)
    puts '!' * 50
    if round_winner
      puts "В раунде победил: #{round_winner}!"
    else
      puts 'Ничья'
    end
    puts '!' * 50
  end

  def result_message(winner)
    puts "Победитель - #{winner}"
    puts '$' * 50
  end

  def comment_message(who, move)
    movement = COMMENTS[move]
    puts "#{who} #{movement}"
  end

  def card_limit_message
    puts 'Достигнут лимит карт.'
  end
end
