class Item
  attr_reader :name, :price

  def initialize(params)
    @name = params[:name]
    @price = make_price(params[:price])
  end

  def make_price(price)
    price.scan(/\d+.\d+/).first.to_f
  end
end
