class Recipes::CoverImageController < ApplicationController
    include ActionView::RecordIdentifier

    before_action :authenticate_user!
    before_action :set_recipe

    def destroy
        @recipe.cover_image.purge_later
        respond_to do |format|
            format.html { redirect_to edit_recipe_path(@recipe) }
            format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@recipe, :cover_image)) }
        end
    end

    private

    def set_recipe
        @recipe = Recipe.find(params[:recipe_id])
    end
end