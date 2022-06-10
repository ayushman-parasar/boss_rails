class Api::ProjectsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_department, only: [:create]

  def create
    project = @department.projects.create(project_params)
    if @project
      return render status: :ok , json: {project: project}
    end
    render status: :unprocessable_entity, json: {errors: project.errors.full_messages}
  end

  private

    def find_department
      @department = Department.find_by(id: params[:department_id])
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
end