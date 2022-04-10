class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8).order(created_at: :desc)
  end

  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
  end
  
  private
  def item_params
    params.require(:item).permit(:image, :name, :price)
  end
end
