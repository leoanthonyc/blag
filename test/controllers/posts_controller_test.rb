# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:one)
  end

  # no valid session

  test 'should get redirected to signin url on index' do
    get user_posts_url(@user)
    assert_redirected_to new_user_session_url
  end

  test 'should get unauthorized error on new' do
    get new_user_post_url(@user, @post)
    assert_response :unauthorized
  end

  test 'should get unauthorized error on create' do
    post user_posts_url(@user, @post), params: { post: { content: @post.content, user_id: @user.id } }
    assert_response :unauthorized
  end

  test 'should get redirected to signin url on show' do
    get user_post_url(@user, @post)
    assert_redirected_to new_user_session_url
  end

  test 'should get redirected to signin url on edit' do
    get edit_user_post_url(@user, @post)
    assert_redirected_to new_user_session_url
  end

  test 'should get redirected to signin url on update' do
    patch user_post_url(@user, @post), params: { post: { content: @post.content, user_id: @post.user_id } }
    assert_redirected_to new_user_session_url
  end

  test 'should get redirected to signin url on destroy' do
    delete user_post_url(@user, @post)
    assert_redirected_to new_user_session_url
  end
end
