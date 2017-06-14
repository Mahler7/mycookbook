require 'test_helper'

class IngredientsNewTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = Chef.create!(chefname: "test", email: "test@gmail.com", password: "password", password_confirmation: "password", admin: true)
    @chef = Chef.create!(chefname: "tester", email: "tester@gmail.com", password: "password", password_confirmation: "password")
    @ingredient = Ingredient.create(name: "chicken")
  end

  test "create valid new ingredient" do
    sign_in_as(@admin, "password")
    get new_ingredient_path
    assert_template "ingredients/new"
    assert_difference "Ingredient.count", 1 do
      post ingredients_path, params: { ingredient: { name: "Eggs" } }
    end
    follow_redirect!
    assert_template "ingredients/show"
    assert_not flash.empty?
  end

  test "create invalid new ingredient" do
    sign_in_as(@admin, "password")
    get new_ingredient_path
    assert_template "ingredients/new"
    assert_no_difference "Ingredient.count" do
      post ingredients_path, params: { ingredient: { name: "" } }
    end
    assert_template "ingredients/new"
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "only admin can create new ingredient" do
    sign_in_as(@chef, "password")
    assert_no_difference "Ingredient.count" do
      post ingredients_path, params: { ingredient: { name: "Pizza" } }
    end
    follow_redirect!
    assert_template "ingredients/index"
    assert_not flash.empty?
  end
end