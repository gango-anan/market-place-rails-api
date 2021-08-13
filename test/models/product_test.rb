require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test 'should have a positive price' do
    product =  products(:one)
    product.price = 1
    assert product.valid?
  end
end
