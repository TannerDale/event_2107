require "./lib/item"
require "./lib/food_truck"

RSpec.describe FoodTruck do
  context 'initialize' do
    food_truck = FoodTruck.new("Rocky Mountain Pies")

    it 'exists' do
      expect(food_truck).to be_a(FoodTruck)
    end

    it 'has attributes' do
      expect(food_truck.name).to eq("Rocky Mountain Pies")
      expect(food_truck.inventory).to eq({})
    end
  end

  context 'stock' do
    food_truck = FoodTruck.new("Rocky Mountain Pies")
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})

    it 'can stock and check stock' do

      food_truck.stock(item1, 30)

      expect(food_truck.inventory).to eq({item1 => 30})

      expect(food_truck.check_stock(item1)).to eq(30)

      food_truck.stock(item1, 25)

      expect(food_truck.check_stock(item1)).to eq(55)

      food_truck.stock(item2, 12)

      expect(food_truck.inventory).to eq(item1 => 55, item2 => 12)
    end

    it 'can check its items' do
      expect(food_truck.items).to eq([item1, item2])
    end

    it 'can check if it can sell' do
      expect(food_truck.can_sell?(item1)).to be(true)
    end

    it 'can calculate potential revenue' do
      expect(food_truck.potential_revenue).to eq(236.25)
    end

    it 'can sell items' do
      food_truck.sell(item2, 11)
      expect(food_truck.check_stock(item2)).to eq(1)
      food_truck.sell(item2, 11)
      expect(food_truck.check_stock(item2)).to eq(0)
    end
  end
end
