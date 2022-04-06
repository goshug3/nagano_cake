class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.page(params[:page])
  end

  def show
  end
  
  private
  def item_params
    params.require(:item).permit(:image, :name, :price)
  end
end
