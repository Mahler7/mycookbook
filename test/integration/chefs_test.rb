require 'test_helper'

class ChefsTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "test", email: "test@gmail.com", password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "tester", email: "tester@gmail.com", password: "password", password_confirmation: "password")
    @admin = Chef.create!(chefname: "test1", email: "test1@gmail.com", password: "password", password_confirmation: "password", admin: true)

  end

  test "should get chefs index page" do
    get chefs_path
    assert_response :success
  end

  test "should get chefs listing" do
    get chefs_path
    assert_template "chefs/index"
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname.capitalize
  end

  test "should delete chef" do
    sign_in_as(@admin, "password")
    get chefs_path
    assert_template "chefs/index"
    assert_difference "Chef.count", -1 do
      delete chef_path(@chef)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
end
