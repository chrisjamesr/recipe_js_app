class CommentsController < ApplicationController
  before_action :current_user

  def index
    recipe = Recipe.find(params[:id])
    @comments = recipe.comments
    render json: @comments,  status: 200
  end

  def create
    recipe = Recipe.find(comment_params[:id])
    @comment = Comment.new(:recipe_id => recipe.id, :user_id => current_user.id, :text => comment_params[:text])
    if @comment.save
      render json: @comment, status: 201
    else
      render json: @comment.errors.full_messages 
    end
    

  end

  private
    def comment_params
      params.permit(:id, :text)
    end

end