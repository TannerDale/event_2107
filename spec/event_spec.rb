require "./lib/item"
require "./lib/food_truck"
require "./lib/event"

RSpec.describe Event do
  context 'initialize' do
    event = Event.new("South Pearl Street Farmers Market")

    it 'exists' do
      expect(event).to be_a(Event)
    end

    it 'has attributes' do
      expect(event.name).to eq("South Pearl Street Farmers Market")
      expect(event.food_trucks).to eq([])
    end

    it 'can add a truck' do
      food_truck1 = FoodTruck.new("Rocky Mountain Pies")
      event.add_food_truck(food_truck1)

      expect(event.food_trucks).to eq([food_truck1])
    end
  end

  context 'behavour' do
    event = Event.new("South Pearl Street Farmers Market")
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    food_truck1.stock(item1, 35)
    food_truck1.stock(item2, 7)
    food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    food_truck2.stock(item4, 50)
    food_truck2.stock(item3, 25)
    food_truck3 = FoodTruck.new("Palisade Peach Shack")
    food_truck3.stock(item1, 65)

    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)

    it 'has fod truck names' do
      expect(event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it 'can check trucks that sell item' do
      expect(event.food_trucks_that_sell(item1)).to eq([food_truck1, food_truck3])
      expect(event.food_trucks_that_sell(item4)).to eq([food_truck2])
    end
  end

  context 'items sold' do
    event = Event.new("South Pearl Street Farmers Market")

    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    food_truck1.stock(item1, 35)
    food_truck1.stock(item2, 7)

    food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    food_truck2.stock(item4, 50)
    food_truck2.stock(item3, 25)

    food_truck3 = FoodTruck.new("Palisade Peach Shack")
    food_truck3.stock(item1, 65)
    food_truck3.stock(item3, 10)

    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)

    it 'has all items' do
      expect(event.all_items).to eq([item1, item2, item4, item3])
    end

    it 'has a total inventory' do
      expected = {
        item1 => {
          quantity: 100,
          food_trucks: [food_truck1, food_truck3]
        },
        item2 => {
          quantity: 7,
          food_trucks: [food_truck1]
        },
        item4 => {
          quantity: 50,
          food_trucks: [food_truck2]
        },
        item3 => {
          quantity: 35,
          food_trucks: [food_truck2, food_truck3]
        }
      }

      expect(event.total_inventory).to eq(expected)
    end

    it 'has overstocked items' do
      expect(event.overstocked_items).to eq([item1])
    end

    it 'has an item list' do
      expect(event.sorted_item_list).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
    end
  end

  context 'iteration 4' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    item5 = Item.new({name: 'Onion Pie', price: '$25.00'})
    event = Event.new("South Pearl Street Farmers Market")
    # event.date
    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    food_truck1.stock(item1, 35)
    food_truck1.stock(item2, 7)
    food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    food_truck2.stock(item4, 50)
    food_truck2.stock(item3, 25)
    food_truck3 = FoodTruck.new("Palisade Peach Shack")
    food_truck3.stock(item1, 65)
    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)

    it 'can sell items' do
      expect(event.sell(item1, 200)).to be(false)

      expect(event.sell(item5, 1)).to be(false)

      expect(event.sell(item4, 5)).to be(true)

      expect(food_truck2.check_stock(item4)).to eq(45)

      expect(event.sell(item1, 40)).to be(true)

      expect(food_truck1.check_stock(item1)).to eq(0)

      expect(food_truck3.check_stock(item1)).to eq(60)
    end
  end
end
