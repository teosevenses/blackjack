
class Card
  SUITS = ['♠', '♣', '♥', '♦'].freeze
  NOMINALS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_reader :suit, :nominal

  def initialize(suit, nominal)
    @suit = suit
    @nominal = nominal
  end

  def value(current_result)
    return 10 if %w[J Q K].include?(@nominal)
    return ace_value(current_result) if @nominal == "A"

    @nominal.to_i
  end

  def ace_value(current_result)
    return 1 if current_result + 11 > 21
    11 
  end

  def to_s
    "#{@nominal}#{@suit}"
  end
end
