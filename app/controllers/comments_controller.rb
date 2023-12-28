class CommentsController < ApplicationController
  #before_action :authenticate_user!, only: [:show]

  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to prototype_path(@prototype)
    else
      render 'prototypes/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to prototype_path(@comment.prototype)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)#.merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
