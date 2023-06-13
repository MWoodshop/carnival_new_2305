class Visitor
  attr_reader :name, :height, :spending_money, :preferences

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = convert_to_integer(spending_money)
    @preferences = []
  end

  def add_preference(preference)
    @preferences << preference
  end

  def tall_enough?(ride)
    @height >= ride.min_height
  end

  def matching_preference?(ride)
    @preferences.include?(ride.excitement)
  end

  def reduce_spending_money(amount)
    @spending_money -= amount
  end

  private

  def convert_to_integer(money)
    money.delete('$').to_i
  end
end
