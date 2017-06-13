require 'test_helper'

class IngredientsTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "test", email: "test@gmail.com", password: "password", password_confirmation: "password")
    @ingredient = Ingredient.create(name: "chicken")
  end

  test "should get ingredients index page" do
    get ingredients_path
    assert_response :success
  end

  test "should get ingredients listing" do
    get ingredients_path
    assert_template "ingredients/index"
    assert_select "a[href=?]", ingredient_path(@ingredient), text: @ingredient.name.capitalize
  end
end
