require "test_helper"

class CommentTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.create(chefname: "testy", email: "testy@gmail.com", password: "password", password_confirmation: "password")
    @recipe = @chef.recipes.build(name: "vegetable", description: "great vegetable recipe")
    @comment = Comment.create(description: "The greatest vegetables ever!", recipe_id: @recipe.id, chef_id: @chef.id)
  end

  test "comment description should be present" do
    @comment.description = ''
    assert_not @comment.valid?
  end

  test "comment description should have a minimum length of 4" do
    @comment.description = 'aaa'
    assert_not @comment.valid?
  end

  test "comment description can only have a maximum length of 140" do
    @comment.description = 'a' * 141
    assert_not @comment.valid?
  end

  test "comment without chef should be invalid" do
    @comment.chef_id = nil
    assert_not @comment.valid?
  end

  test "comment without recipe should be invalid" do
    @comment.recipe_id = nil
    assert_not @comment.valid?
  end

end