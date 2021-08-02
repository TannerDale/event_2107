class FoodTruck
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def stock(item, amount)
    @inventory[item] += amount
  end

  def check_stock(item)
    @inventory[item]
  end

  def can_sell?(item)
    @inventory.has_key?(item) && inventory[item] > 0
  end
end
