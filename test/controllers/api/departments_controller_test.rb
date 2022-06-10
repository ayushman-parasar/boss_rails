# frozen_string_literal: true

require "test_helper"

class Api::DepartmentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @department = Department.create({name: "dep 1", description: "desc of dep1"})
    @project = @department.projects.create({name: "project 1", description: "desc of project 1"})
  end


  def test_api_gets_departments_gets_all_departments_along_with_related_projects
    get api_departments_path 
    assert_response :success
    assert_equal @project.id, JSON.parse(response.body)["departments"][2]["projects"][0]["id"]
  end
end
