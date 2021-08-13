require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test 'should have a positive price' do
    product =  products(:one)
    product.price = 1
    assert product.valid?
  end

  test 'should filter products by name' do
    assert_equal 2, Product.filter_by_title('tv').count
  end

  test 'should filter products by name and sort them' do
    assert_equal [products(:another_tv), products(:one)], Product.filter_by_title('tv').sort
  end

  test 'should filter products by price and sort them' do
    assert_equal [products(:two), products(:one)], Product.above_or_equal_to_price(200).sort
  end

  test 'should filter products by price lower and sort them' do
    assert_equal [products(:another_tv)], Product.below_or_equal_to_price(200).sort
  end

  test 'should sort products by most recent' do
    products(:two).touch
    assert_equal [products(:another_tv), products(:one), products(:two)], Product.recent.to_a
  end
end
