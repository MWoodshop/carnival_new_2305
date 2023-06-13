class Visitor
  attr_reader :name, :height, :spending_money, :preferences

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money
    @preferences = []
  end

  def add_preference(preference)
    @preferences << preference
  end

  def tall_enough?(ride)
    @height >= ride.min_height
  end

  # def has_matching_preference?(ride)
  #   @preferences.include?(ride.excitement)
  # end
end
