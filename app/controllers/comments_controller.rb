class CommentsController < ApplicationController
  def index
    @type = params[:type]
    @id = params[:id]
    @comments = Comment.find(:conditions => { :commentable_type => @type.titleize, :commentable_id => BSON::ObjectId(@id) })
    @comment = Comment.new(:commentable_type => @type.titleize, :commentable_id => @id)
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.commentable_type = @comment.commentable_type.titleize
    @comment.user_id = current_user.id
    if @comment.save
      @success = true
    else
      @success = false
    end
  end
end