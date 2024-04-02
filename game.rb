
require_relative 'user'
require_relative 'dealer'
require_relative 'deck'
require_relative 'card'

class Game
  attr_reader :user, :dealer, :deck, :name

  def initialize
    @deck = Deck.new
    begin
      puts 'Вы зашли в игру блек джек, назовите себя!'
      @name = gets.chomp
      validate!
    rescue RuntimeError => e
      puts e.message
      retry
    end
    @user = User.new(@name, 100)
    @dealer = Dealer.new(100)
  end

  def start
    loop do
      start_round
      user_turn
      dealer_turn if user.points <= 21
      show_final_result
      break unless play_again?

      retry_round
    end
    puts "Спасибо за игру #{user.name}, всего хорошего!"
  end

  private

  def validate!
    raise 'Неверное имя, попробуйте снова' if @name.strip.empty?
  end

  def start_round
    deal_cards(2, user)
    deal_cards(2, dealer)
    bet
    show_hands
  end

  def deal_cards(num, player)
    num.times { player.take_card(deck) }
  end

  def user_turn # rubocop:disable Metrics/AbcSize
    puts "Ваш выбор #{user.name}!"
    choice = nil
    until choice == 'остановиться' || user.hand.size == 3
      puts 'Какой ваш следующий шаг: взять карту, остановиться, показать свои карты'
      choice = gets.chomp.downcase
      case choice
      when 'взять карту'
        user.take_card(deck) if user.hand.size == 2
        show_hands
      when 'показать свои карты'
        break
      end
    end
  end

  def dealer_turn
    puts "выбор Дилера"
    dealer.take_card(deck) if dealer.points < 17 && dealer.hand.size == 2
  end

  def show_hands
    puts "Карты игрока: #{user.name} #{user.show_hand}"
    puts "Карты дилера: #{dealer.show_hand}"
  end

  def dealer_hand
    puts "Итоговые карты дилера #{dealer.hand.map(&:to_s).join(', ')}"
    puts "Очки дилера #{dealer.points}"
  end

  def show_final_result
    dealer_hand

    if user.points > 21
      puts "У #{user.name} недостаточно средств, победа дилера."
      dealer.bank += 20
    elsif dealer.points > 21 || user.points > dealer.points
      puts "Игрок под именем #{user.name} выиграл"
      user.bank += 20
    elsif user.points < dealer.points
      puts 'Победил дилер'
      dealer.bank += 20
    else dealer_points || user.points == 21
      puts "Случилась ничья"
      user.bank += 10
      dealer.bank += 10
    else
      puts "Случилась ничья"
      user.bank += 10
      dealer.bank += 10
    end
  end

  def bet
    user.bet(10)
    dealer.bet(10)
  end

  def play_again?
    puts 'Попробуете снова? (да/нет)'
    answer = gets.chomp.downcase
    answer == 'да'
  end

  def retry_round
    @deck = Deck.new
    user.hand.clear
    dealer.hand.clear
  end
end

game = Game.new
game.start
