class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.order(created_at: :desc) 
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :product_description, :category_id, :item_status_id, :shipping_cost_burden_id, :shipping_from_id, :shipping_day_id, :price, :product_image ).merge(user_id: current_user.id)
  end
end