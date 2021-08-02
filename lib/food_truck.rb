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
    inventory[item] > 0
  end

  def potential_revenue
    @inventory.sum do |item, amount|
      amount * item.price
    end
  end

  def items
    @inventory.keys
  end

  def sell(item, amount)
    @inventory[item] -= amount
    @inventory[item] = 0 if @inventory[item] <= 0
  end
end
