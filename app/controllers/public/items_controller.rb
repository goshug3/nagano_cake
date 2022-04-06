class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.page(params[:page])
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
  end
  
  private
  def item_params
    params.require(:item).permit(:image, :name, :price)
  end
end
