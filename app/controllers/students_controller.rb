class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def index
    students = Student.all
    json render: students, status: :ok
  end

  def show 
    student = Student.find(params[:id])
    json render: student, status: :ok
  end

  def create
    student = Student.create!(student_params)
    json render: student, status: :created
  end

  def update
    student = Student.find(params[:id])
    json render: student.update!(student_params), status: :ok
  end

  def destroy
    student = Studnet.find(params[:id])
    student.destroy
    head :no_content
  end

  private
  def student_params
    params.permit(:name, :age, :major, :instructor_id)
  end
  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end
  def record_invalid(error)
    render json: { error: error.messages }, status: :unprocessable_entity
  end
end


