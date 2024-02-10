class MigrateRecipeNotesToActionText < ActiveRecord::Migration[7.1]
  include ActionView::Helpers::TextHelper
  def change
    rename_column :recipes, :notes, :notes_old
    Recipe.all.each do |recipe|
      recipe.update_attribute(:notes, simple_format(recipe.notes_old))
    end
    remove_column :recipes, :notes_old
  end
end