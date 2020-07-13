class RecipesController < ApplicationController
  
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # - "require_user" asalnya dari application_controller.rb
  # - "require_user" ini maksudnya adalah, hanya user yg sudah login saja yg bisa mengakses method2 tertentu 
  #   (seperti update, delete dll)

  # - "require_same_user" ini maksudnya hanya user yg membuat resep itu dan yg sudah login saja yg bisa mengeditnya dll
  # - "require_same_user" ini didefinisikan di bagian bawah halaman ini

  # - "require_user" dan "require_same_user" ini dimaksudkan utk pertahanan kalau ada orang yg mau mengakses langsung dari URL, 
  #    bukan dari view di browser 

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_chef
    if @recipe.save
      flash[:success] = "Recipe was created successfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe was updated successfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end
  
  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe deleted successfully"
    redirect_to recipes_path
  end
  
  private
  
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
  
    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end

    def require_same_user

      # Ini maksudnya adalah: "Kalau current_chef (chef yg sedang login) bukan pemilik resep tsb DAN bukan admin maka muncul flash"
    
      if current_chef != @recipe.chef and !current_chef.admin? 
        flash[:danger] = "You can only edit or delete your own recipes"
        redirect_to recipes_path
      end  
    end

end