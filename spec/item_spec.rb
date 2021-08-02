require './lib/item'

RSpec.describe Item do
  context 'initialize' do
    item = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})

    it 'exists' do
      expect(item).to be_a(Item)
    end

    it 'has attributes' do
      expect(item.name).to eq('Apple Pie (Slice)')
      expect(item.price).to eq(2.50)
    end
  end
end
