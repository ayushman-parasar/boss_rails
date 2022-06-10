class Api::DepartmentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_department, only: [:update, :show]

  def create
    department = Department.create(department_params)
    if department
      return render status: :ok , json: {department: department}
    end
    render status: :unprocessable_entity, json: {errors: department.errors.full_messages}
  end

  def update
    if @department.update(department_params)
      return render status: :ok , json: {department: @department}
    end
    render status: :unprocessable_entity, json: {errors: @department.errors.full_messages}
  end

  def index
    begin
      departments = Department.joins(:projects)
      departments_with_associations = departments.map do |department|
        department.attributes.merge(
          projects: department.projects
        )
      end
      render status: :ok , json: {departments: departments_with_associations }
    rescue => ex
      render status: :unprocessable_entity, json: {errors: ex}
    end
  end

  def show
    if @department
      return render status: :ok , json: {department: @department}
    end
    render status: :unprocessable_entity, json: {errors: @department.errors.full_messages}
  end

  private
    def find_department
      @department = Department.find_by(id: params[:id])
    end

    def department_params
      params.require(:department).permit(:name, :description, :first_created_at)
    end
end