require "test_helper"

class DepartmentTest < ActiveSupport::TestCase
  def test_valid_department
    dep = Department.create({name: "", description: ""})
    assert_not dep.valid?
  end
end
