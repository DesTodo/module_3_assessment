class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

  def show
    render json: @item
  end

  def index
    render json: Item.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save render json: @item
    end
  end

  def destroy
    @item.destroy
  end

  private

  def item_params
    params.permit(:name, :description, :image_url)
  end

  def set_item
    @item = Item.find(params[:id]) #for methods that act on a specific instance id sent in params
  end
end
