class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.float :servings
      t.text :instructions
      t.text :notes

      t.timestamps
    end
  end
end
