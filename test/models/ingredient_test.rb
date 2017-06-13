require 'test_helper'

class IngredientTest < ActiveSupport::TestCase

  def setup
    @ingredient = Ingredient.create(name: "chicken")
  end

  test "ingredient name should be present" do 
    @ingredient.name = ''
    assert_not @ingredient.valid?
  end
    
  test "ingredient name should be unique" do
    duplicate_ingredient = @ingredient.dup
    assert_not duplicate_ingredient.valid?
  end

  test "ingredient name should have a minimum length of 3" do
    @ingredient.name = 'aa'
    assert_not @ingredient.valid?
  end

  test "ingredient name can only have a maximum length of 25" do
    @ingredient.name = 'a' * 26
    assert_not @ingredient.valid?
  end
end