require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "tester", email: "tester@gmail.com", password: "password", password_confirmation: "password")
    @recipe = Recipe.create!(name: "vegetable saute", description: "add vegetable and oil", chef: @chef)
    @comment = Comment.create!(description: "This is the test comment", chef_id: @chef.id, recipe_id: @recipe.id)
  end

  test "creates a valid comment" do
    sign_in_as(@chef, "password")
    get recipe_path(@recipe)
    assert_template "recipes/show"
    assert_difference "Comment.count", 1 do
      post recipe_comments_path(@recipe.id), params: { comment: { description: "A new comment", chef_id: @chef.id, recipe_id: @recipe.id } }
    end
    follow_redirect!
    assert_template "recipes/show"
    assert_not flash.empty?
    assert_match "A new comment", response.body
  end

  test "creates an invalid comment" do
    sign_in_as(@chef, "password")
    get recipe_path(@recipe)
    assert_template "recipes/show"
    assert_no_difference "Comment.count" do
      post recipe_comments_path(@recipe.id), params: { comment: { description: "", chef_id: "", recipe_id: "" } }, headers: { "HTTP_REFERER" => "http://www.example.com/recipes/#{@recipe.id}" }
    end
    follow_redirect!
    assert_template "recipes/show"
    assert_not flash.empty?
  end

end
