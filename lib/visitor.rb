class Visitor
  attr_reader :name, :age, :spending_money, :interests

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money
  end
end
