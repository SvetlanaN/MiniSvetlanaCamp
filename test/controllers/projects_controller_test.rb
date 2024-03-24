require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user1)
    @project = projects(:project1)
  end

  test "should get index" do
    log_in_as(@user)
    get projects_url
    assert_response :success
  end

  test "should show project" do
    log_in_as(@user)
    get project_url(@project)
    assert_response :success
  end

  test "should not get new when not logged in" do
    get new_project_url
    assert_redirected_to login_url
  end

  test "should get new when logged in" do
    log_in_as(@user)
    get new_project_url
    assert_response :success
  end

  test "should not create project when not logged in" do
    assert_no_difference('Project.count') do
      post projects_url, params: { project: { name: "New Project" } }
    end
    assert_redirected_to login_url
  end

  test "should create project when logged in" do
    log_in_as(@user)
    assert_difference('Project.count') do
      post projects_url, params: { project: { name: "New Project", description: "Project description", created_at: "2024-01-01", updated_at: "2024-01-01" } }
    end
    assert_redirected_to project_url(Project.last)
  end

  test "should not get edit when not logged in" do
    get edit_project_url(@project)
    assert_redirected_to login_url
  end

  test "should get edit when logged in" do
    log_in_as(@user)
    get edit_project_url(@project)
    assert_response :success
  end

  private

  def log_in_as(user)
    post login_url, params: { session: { email: user.email, password: 'password' } }
  end
end
