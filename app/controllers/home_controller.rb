# frozen_string_literal: true

# no-doc
class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts
    render 'posts/index'
  end
end
