class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

  def show
    render json: @item
  end

  def index
    render json: Item.all
  end

  def create
      render json: {
        item: Item.create(item_params),
        status: 201
      }, status: 201
  end

  def destroy
    @item.destroy
    render json: {
      status: 204
    }, status: 204
  end

  private

  def item_params
    params.permit(:name, :description, :image_url)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
