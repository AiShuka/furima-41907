class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!, only: [:index, :create]
  before_action :redirect_if_seller, only: [:index, :create]
  before_action :redirect_if_sold_out, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if  @purchase_form.valid?
      pay_item
      @purchase_form.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_seller
    if current_user == @item.user
      redirect_to root_path
    end
  end

  def redirect_if_sold_out
    if @item.purchase.present? 
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: purchase_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def purchase_params
    params.require(:purchase_form).permit(
      :postal_code, :shipping_from_id, :city, :street_address, :building_name, :phone_number)
      .merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token]
      )
  end
end