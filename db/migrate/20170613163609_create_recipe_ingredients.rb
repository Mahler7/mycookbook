class CreateRecipeIngredients < ActiveRecord::Migration[5.0]
  def change
    drop_table :recipe_ingredients
    create_table :recipe_ingredients do |t|
      t.integer :recipe_id
      t.integer :ingredient_id
    end
  end
end
