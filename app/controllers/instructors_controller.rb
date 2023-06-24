class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def index
    instructors = Instructor.all
    json render: instructors, status: :ok
  end

  def show 
    instructor = Instructor.find(params[:id])
    json render: instructor, status: :ok
  end

  def create
    instructor = Instructor.create!(instructor_params)
    json render: instructor, status: :created
  end

  def update
    instructor = Instructor.find(params[:id])
    json render: instructor.update!(instructor_params), status: :ok
  end

  def destroy
    instructor = Instructor.find(params[:id])
    instructor.destroy
    head :no_content
  end

  private
  def instructor_params
    params.permit(:name)
  end
  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end
  def record_invalid(error)
    render json: { error: error.messages }, status: :unprocessable_entity
  end
end
