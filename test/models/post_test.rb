# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'missing content' do
    post = Post.new
    assert_not post.save
  end

  test 'missing user' do
    post = Post.new(content: 'Hello')
    assert_not post.save
  end

  test 'complete fields' do
    post = Post.new(content: 'Hello', user: User.first)
    assert post.save
  end
end
