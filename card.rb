
class Card
  SUITS = ['♠', '♣', '♥', '♦'].freeze
  NOMINALS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_reader :suit, :rank

  def initialize(suit, nominal)
    @suit = suit
    @nominal = nominal
  end

  def value 
    return 10 if %w[J Q K].include?(@nominal) 
    return [1, 11] if @nominal == "A" 
    @nominal.to_i 
  end

  def to_s
    "#{@nominal}#{@suit}"
  end
end
