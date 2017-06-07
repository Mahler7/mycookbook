require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "test", email: "test@gmail.com", password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "tester", email: "tester@gmail.com", password: "password", password_confirmation: "password")
    @admin = Chef.create!(chefname: "test1", email: "test1@gmail.com", password: "password", password_confirmation: "password", admin: true)
  end

  test "reject invalid chef edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: '', email: '' } }
    assert_template "chefs/edit"
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept valid chef edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: 'testy', email: "testy@gmail.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match 'testy', @chef.chefname
    assert_match 'testy@gmail.com', @chef.email
  end

  test "accept edit attempt by admin" do
    sign_in_as(@admin, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: 'testy', email: "testy@gmail.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match 'testy', @chef.chefname
    assert_match 'testy@gmail.com', @chef.email
  end

  test "redirect edit attempt by non-admin" do
    sign_in_as(@chef2, "password")
    updated_name = "Joe"
    updated_email = "joe@example.com"
    patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email } }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match 'test', @chef.chefname
    assert_match 'test@gmail.com', @chef.email
  end
end
