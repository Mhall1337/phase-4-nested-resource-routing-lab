class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  def index
    items = Item.all
    render json: items, include: :user
  end

  def show
    item = Item.find_by!(id: params[:id])
    render json: item, include: :user
  end

  def create
    user = User.find_by!(id: params[:id])
    item = user.items.create(strong_params)
    render json: item, status: :created
  end
 

  private

  def strong_params
    params.permit(:name, :description, :price, :user_id, :user, :id)
  end

  def render_unprocessable_response(invalid)
    render json: {error: invalid.record.errors}, status: :unprocessable_entity
  end

  def render_record_not_found
    render json: {error: 'not found'}, status: :not_found
  end

end
