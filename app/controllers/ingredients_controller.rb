class IngredientsController < ApplicationController
    def new
        @ingredient = Ingredient.new
    end
    
    def create
        @recipe = Recipe.find(params[:recipe_id])
        @ingredient = @recipe.ingredients.create(ingredient_params)
        redirect_to recipe_path(@recipe)
    end

    def destroy
        @recipe = Recipe.find(params[:recipe_id])
        @ingredient = @recipe.ingredients.find(params[:id])
        @recipe.destroy
        redirect_to recipe_path(@recipe), status: :see_other

    private
        def ingredient_params
            params.require(:ingredient).permit(:name, :quantity, :measure)
        end
    end
end