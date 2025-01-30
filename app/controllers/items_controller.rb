class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_if_not_seller, only: [:edit, :update, :destroy] 
  before_action :redirect_if_sold_out, only: [:edit, :update] 

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

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
      @item.destroy
      redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def authenticate_user_for_item
    redirect_to root_path if @item.user != current_user
  end

  def redirect_if_not_seller
    redirect_to root_path if current_user != @item.user
  end

  def redirect_if_sold_out
    if @item.purchase.present?
      redirect_to root_path
    end
  end

  def item_params
    params.require(:item).permit(:product_name, :product_description, :category_id, :item_status_id, :shipping_cost_burden_id, :shipping_from_id, :shipping_day_id, :price, :product_image ).merge(user_id: current_user.id)
  end
end