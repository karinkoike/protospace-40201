class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    #@user = User.new
    @prototype = Prototype.new
  end

  def create
    #@user =User.new(user_params)
    @prototype = current_user.prototypes.build(prototype_params)
    
    #if @user.save
      #redirect_to user_registration_path(@user)
    #else
      if @prototype.save
        #@comment = @prototype.comments.build(comment_params.merge(user: current_user))
        if @prototype.save
          redirect_to root_path #prototype_path(@prototype)
        else
          render :new, status: :unprocessable_entity
        end
      end
    #end
  end

  def show
    #@user = User.find(params[:id])
    #@prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comment = @prototype.comments

    respond_to do |format|
      format.html
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy

    redirect_to prototypes_path
  end

  private
  #def user_params
    #params.require(:user).permit(:name,:image).merge(user_id: current_user.id)
  #end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end


  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def authorize_user
    unless user_signed_in? && @prototype.user == current_user
      redirect_to root_path #new_user_session_path root_path
    end
  end
end
