class Recipes::CoverImageController < ApplicationController
    before_action :authenticate_user!
    before_action :set_recipe

    def destroy
        @recipe.cover_image.purge_later
        redirect_to edit_recipe_path(@recipe)
    end

    private

    def set_recipe
        @recipe = Recipe.find(params[:recipe_id])
    end
end