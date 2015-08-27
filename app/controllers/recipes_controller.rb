class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :like, :review]
  before_action :require_user, except: [:show, :index, :like]
  before_action :require_user_like, only: [:like]
  before_action :require_same_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    #@recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user
    if @recipe.save
      flash[:success] = "Your recipe was created successfully"
      redirect_to recipes_path
    else
      render :new
    end
  end
  
  def show
    
  end
  
  def edit
   
  end
  
  def update
    
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully!"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
    
  end
  
  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe Deleted"
    redirect_to recipes_path
  end
  
  def like
    
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection was successful"
      redirect_to :back
    else
      flash[:danger] = "You can like/dislike recipe only once"
      redirect_to :back
    end
  end
  
  def review
    review = Review.create(content: params[:content], chef: current_user, recipe: @recipe)
    if review.valid?
      flash[:success] = "Thank you for reviewing this recipe"
    else
      flash[:danger] = "Review failed to post"
    end
    redirect_to :back
  end
  
  def deletereview
    Review.find(params[:revid]).destroy
    flash[:success] = "Review deleted"
    redirect_to :back
  end
  
  private 
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture, :picture1, :picture2, :picture3, style_ids: [], ingredient_ids: [])
    end
    
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    
    def require_same_user
      if current_user != @recipe.chef and !current_user.admin?
        flash[:danger] = "You can edit only your own recipe"
        redirect_to root_path
      end
    end
    
     def require_user_like
      if !logged_in?
        flash[:danger] = "You must be logged in to perform this action"
        redirect_to :back
      end
     end
     
     def admin_user
      redirect_to recipes_path unless current_user.admin? 
     
     end
  
end