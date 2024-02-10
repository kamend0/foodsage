class MigrateRecipeInstructionsToActionText < ActiveRecord::Migration[7.1]
  include ActionView::Helpers::TextHelper
  def change
    rename_column :recipes, :instructions, :instructions_old
    Recipe.all.each do |recipe|
      recipe.update_attribute(:instructions, simple_format(recipe.instructions_old))
    end
    remove_column :recipes, :instructions_old
  end
end