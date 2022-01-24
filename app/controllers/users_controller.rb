class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_response
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
 
  def show
    user = User.find_by!(id: params[:id])
    render json: user, include: :items
  end

  def index
    users = User.all
    render json: users, include: :items
  end
  
  def create
    user = User.create(strong_params)
    render json: user, status: :created
  end

  private

  def strong_params
    params.permit(:username, :city)
  end
  def render_unprocessable_response(invalid)
    render json: {error: invalid.record.errors}, status: :unprocessable_entity
  end

  def render_record_not_found
    render json: {error: 'not found'}, status: :not_found
  end

end
