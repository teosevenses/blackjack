
class User
  attr_reader :name, :hand
  attr_accessor :bank

  def initialize(name, bank_amount)
    @name = name
    @hand = []
    @bank = bank_amount
  end

  def take_card(deck)
    deck.rebuild_deck if deck.empty?
    @hand << deck.deal_card
  end

  def bet(amount)
    raise 'Недостаточно средств' unless amount <= @bank

    @bank -= amount
    amount
  end

  def points
    result = 0

    @hand.each do |card|
      result += card.value(result)
    end
    result
  end

  def take
    if points < 17
      take_card(deck)
    else
      false
    end
  end

  def show_hand
    hand_string = @hand.map(&:to_s).join(', ')
    "У игрока #{@name} на руках карты [#{hand_string}], сумма очков - #{points}"
  end

  def show_bank
    "У игрока #{@name} банк равен #{@bank}"
  end
end

