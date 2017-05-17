class ChangeColumnInRecipes < ActiveRecord::Migration[5.0]
  def change
    rename_column :recipes, :user_id, :chef_id
  end
end
