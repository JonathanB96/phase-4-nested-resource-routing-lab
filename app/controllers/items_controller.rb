class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from NoMethodError, with: :render_not_found_response
  def index
    if params[:user_id]

      user = User.find_by(id: params[:user_id])
      all_items = user.items
      render json: all_items, include: :user
    else
      items = Item.all 
      render json: items, include: :user
    end

    
  end

  def show
    if params[:user_id] && params[:id]
      item = Item.find(params[:id])
      render json: item
    else

     
    end
  

  end

  def create
    if params[:user_id]
      user = User.find(params[:user_id])
      
      item = user.items.create(params.permit(:name, :description, :price))
      render json: item, status: :created
    end


  end
  private
  def render_not_found_response
    render json: { error: "Not found" }, status: :not_found
  end


end
