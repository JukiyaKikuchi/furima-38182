class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :find_item, only: [:index, :create]

  def index
    @order_delivery = OrderDelivery.new
    if @item.user_id == current_user.id || @item.order != nil
      redirect_to root_path
    end
  end

  def create
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to root_path
    else
      render :'orders/index'
    end
  end

  private

  def order_params
    params.require(:order_delivery).permit(:postcode, :city, :address, :building, :tell_number, :prefecture_id).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token],)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.item_price,  
      card: order_params[:token],    
      currency: 'jpy'                 
    )
  end

  def find_item
    @item = Item.find(params[:item_id])
  end


end
