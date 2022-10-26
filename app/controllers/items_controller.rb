class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_item, only: [:edit, :update]
  before_action :corect_user, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order("created_at DESC")
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
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :item_description, :item_price, :image, :category_id, :item_status_id, :delivery_date_id, :delivery_cost_id, :prefecture_id).merge(user_id: current_user.id)
  end
  def find_item
    @item = Item.find(params[:id])
  end
  def corect_user
    @item = Item.find(params[:id])
    @user = @item.user
    redirect_to(items_path) unless @user == current_user
  end
end
