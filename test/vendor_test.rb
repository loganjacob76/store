require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/vendor'

class VendorTest < Minitest::Test
  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_attributes
    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal ({}), @vendor.inventory
  end

  def test_check_stock
    assert_equal 0, @vendor.check_stock(@item1)
  end

  def test_stock_item
    @vendor.stock(@item1, 30)
    assert_equal ({@item1 => 30}), @vendor.inventory
    assert_equal 30, @vendor.check_stock(@item1)

    @vendor.stock(@item2, 12)
    assert_equal ({@item1 => 30, @item2 => 12}), @vendor.inventory
  end

  def test_potential_revenue
    @vendor.stock(@item1, 30)
    @vendor.stock(@item2, 12)

    assert_equal 28.50, @vendor.potential_revenue
  end

  def test_item_names
    @vendor.stock(@item1, 30)
    assert_equal ['Peach'], @vendor.item_names

    @vendor.stock(@item2, 12)
    assert_equal ['Peach', 'Tomato'], @vendor.item_names
  end
end
