class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item_name)
    @vendors.find_all do |vendor|
      vendor.item_names.include?(item_name)
    end
  end

  def total_inventory
    inventory_items = Hash.new {|hash, key| hash[key] = {quantity: 0, vendors: []}}
    @vendors.each do |vendor|
      vendor.inventory.each do |item , amount|
        inventory_items[item][:quantity] += amount
        inventory_items[item][:vendors] << vendor
      end
    end
    inventory_items
  end

  def overstocked_items
    items = []
    total_inventory.each do |item, info|
      if info[:quantity] > 50 && info[:vendors].count > 1
        items << item
      end
    end
    items
  end
end
