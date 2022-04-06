class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def create
    @order = current_customer.orders.new(order_params)
    cart_items = current_customer.cart_items.all
    @order.save
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = @order.id
      order_detail.amount = cart_item.amount
      order_detail.price = cart_item.item.with_tax_price
      order_detail.save
    end
    cart_items.destroy_all
    redirect_to complete_path
  end
  
  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      address_new = current_customer.orders.new(order_params)
      address_new.save
    end
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.subtotal}
    @order.shipping_cost = "800"
    @order.total_payment = @order.shipping_cost + @total_price
  end
  
  def index
  end

  def show
  end
  
  private
  def order_params
      params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment, :order_status)
  end
end
