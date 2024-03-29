class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[ show edit update destroy ]

  # GET /recipes or /recipes.json
  def index
    if params[:q].present? && !params[:q].empty?
      if params[:q].include? ","  # Ingredient search
        # Recipe.search_by_ingredients(current_user, params[:q])
        ingredients = params[:q].split(',').map(&:strip)
        @recipes = current_user.recipes.joins(:ingredients)
                               .where(ingredients.map { |ingredient| '"ingredients"."name" LIKE ?' }.join(' OR '),
                                      *ingredients.map { |ingredient| "%#{ingredient.downcase}%" })
                               .group('recipes.id')
                               .having('COUNT(recipes.id) = ?', ingredients.size)

        @recipes = @recipes.includes(:ingredients)  # Eager load to avoid N+1 queries
      else
        @recipes = current_user.recipes.where('lower(title) LIKE ?', "%#{params[:q].downcase}%")
      end
    else
      @recipes = current_user.recipes.all
    end
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = current_user.recipes.new
    @recipe.ingredients.build
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = current_user.recipes.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = current_user.recipes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(
        :title, :description, :servings, :instructions, :notes, :cover_image,
        ingredients_attributes: [:id, :name, :quantity, :measure, :_destroy]
      )
    end
end
