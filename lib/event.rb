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
        truck.inventory[item]
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
    end.uniq.sort
  end
end
