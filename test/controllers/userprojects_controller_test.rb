# frozen_string_literal: true

require 'test_helper'

class UserprojectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @user = users(:two)
    @project = projects(:one)
    @userproject = userprojects(:one)
  end

  test 'should get index' do
    get userprojects_url
    assert_response :success
  end

  test 'should get new' do
    @user = Userproject.find(@userproject.id)
    get new_userproject_url(id: @user.project_id)
    assert_response :success
  end

  test 'should create userproject' do
    assert_difference('Userproject.count') do
      post userprojects_url, params: { userproject: { project_id: @project.id,
                                                      role: 'Team lead',
                                                      user_id: @user.id } }
    end

    assert_redirected_to userproject_url(Userproject.last)
  end

  test 'should show userproject' do
    get userproject_url(@userproject)
    assert_response :success
  end

  test 'should destroy userproject' do
    assert_difference('Userproject.count', -1) do
      delete userproject_url(@userproject)
    end

    assert_redirected_to userprojects_url(id: @userproject.project_id)
  end

  test 'should cancel userproject' do
    @user = Userproject.where(project_id: @userproject.project_id)
    @user.destroy_all
    assert_equal 0, @user.count
  end
end
