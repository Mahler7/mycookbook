class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    drop_table :ingredients
    create_table :ingredients do |t|
      t.string :name
    end
  end
end
