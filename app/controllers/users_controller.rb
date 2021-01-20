# frozen_string_literal: true

# no-doc
class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @posts = current_user.posts
    render 'posts/index'
  end
end
