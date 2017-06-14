require 'test_helper'

class IngredientsEditTest < ActionDispatch::IntegrationTest
  def setup
    @admin = Chef.create!(chefname: "test", email: "test@gmail.com", password: "password", password_confirmation: "password", admin: true)
    @chef = Chef.create!(chefname: "tester", email: "tester@gmail.com", password: "password", password_confirmation: "password")
    @ingredient = Ingredient.create(name: "chicken")
  end

  test "make valid ingredient edits" do
    sign_in_as(@admin, "password")
    get edit_ingredient_path(@ingredient)
    assert_template "ingredients/edit"
    patch ingredient_path(@ingredient), params: { ingredient: { name: "Pizza" } }
    assert_redirected_to @ingredient
    assert_not flash.empty?
    @ingredient.reload
    assert_match "Pizza", @ingredient.name
  end

  test "make invalid ingredient edits" do
    sign_in_as(@admin, "password")
    get edit_ingredient_path(@ingredient)
    assert_template "ingredients/edit"
    patch ingredient_path(@ingredient), params: { ingredient: { name: "" } }
    assert_template "ingredients/edit"
    @ingredient.reload
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "only admin can make ingredient edits" do
    sign_in_as(@chef, "password")
    patch ingredient_path(@ingredient), params: { ingredient: { name: "Pizza" } }
    follow_redirect!
    assert_template "ingredients/index"
    assert_not flash.empty?
  end
end
