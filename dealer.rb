

class Dealer < User
  def initialize(bank_amount = 100)
    super('Dealer', bank_amount)
  end

  def take
    if points < 17
      take_card(deck)
    else
      false
    end
  end

  def show_hand
    if @hand.size > 1
      "Карты дилера скрыты"
    else
      super
    end
  end
end