class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = current_customer.cart_items.all.order(created_at: :desc)
    @total_price = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    # 外部キーに値を入れなければデータの保存ができない
    @cart_item.customer_id = current_customer.id
    # 同じ商品が追加された場合、個数だけを増やす
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      if cart_item.item_id == @cart_item.item_id
        new_amount = cart_item.amount + @cart_item.amount
        cart_item.update_attribute(:amount, new_amount)
        @cart_item.delete
      end
    end
    @cart_item.save
    redirect_to public_cart_items_path(current_customer.id)
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to public_cart_items_path(current_customer.id)
  end
  
  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to public_cart_items_path(current_customer.id)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path(current_customer.id)
  end
  
  private
  
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
