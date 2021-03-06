# frozen_string_literal: true

# nodoc
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[new create]
  before_action :set_comment, only: %i[show edit update]
  before_action :authorize_user!, only: %i[edit update]

  def new
    @comment = @post.comments.new(user: current_user)
  end

  def edit; end

  def create
    @comment = @post.comments.new(comment_params.merge(user: current_user))
    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@comment.user, @comment.post], notice: 'Comment was successfully created.' }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@comment, partial: 'comments/form', locals: { comment: @comment })
        end
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to [@comment.user, @comment.post], notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to [@post.user, @post], notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def authorize_user!
    raise 'Unauthorized' unless @comment.user == current_user
  end
end
