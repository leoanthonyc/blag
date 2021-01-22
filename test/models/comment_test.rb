# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'missing post' do
    comment = Comment.new(content: 'First!')
    assert_not comment.save
  end

  test 'missing user' do
    comment = Comment.new(content: 'Hello', post: Post.first)
    assert_not comment.save
  end

  test 'complete fields' do
    comment = Comment.new(content: 'Hello', post: Post.first, user: User.first)
    assert comment.save
  end
end
