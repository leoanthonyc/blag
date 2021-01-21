# frozen_string_literal: true

# no-doc
class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.order(created_at: :desc)
  end
end
