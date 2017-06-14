require 'test_helper'

class IngredientsTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "test", email: "test@gmail.com", password: "password", password_confirmation: "password")
    @ingredient = Ingredient.create(name: "chicken")
    @recipe = Recipe.create(name: "vegetable saute", description: "add vegetable and oil", chef_id: @chef.id)
    @recipe.ingredients << @ingredient
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

  test "should get ingredients show" do
    get ingredient_path(@ingredient)
    assert_template "ingredients/show"
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_match "Chicken", @ingredient.name.capitalize
  end
end
