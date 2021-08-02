class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    @food_trucks << truck
  end

  def food_truck_names
    @food_trucks.map do |truck|
      truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |truck|
      truck.can_sell?(item)
    end
  end

  def total_inventory
    all_items.map do |item|
      trucks = food_trucks_that_sell(item)
      amount = trucks.sum do |truck|
        truck.check_stock(item)
      end
      inner_hash = { quantity: amount, food_trucks: trucks}
      [item, inner_hash]
    end.to_h
  end

  def all_items
    @food_trucks.flat_map do |truck|
      truck.items
    end.uniq
  end

  def overstocked_items
    total_inventory.select do |item, data|
      data[:food_trucks].size > 1 && data[:quantity] > 50
    end.keys
  end

  def sorted_item_list
    all_items.map do |item|
      item.name
    end.sort
  end

  def sell(item, amount)
    trucks = food_trucks_that_sell(item)
    if trucks.size > 0 && total_inventory[item][:quantity] >= amount
      sell_items(trucks, item, amount)
      return true
    end
    false
  end

  def sell_items(trucks, item, amount)
    trucks.each do |truck|
      total_sold = truck.check_stock(item)
      truck.sell(item, amount)
      amount -= total_sold
    end
  end
end
