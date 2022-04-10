class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.shipping_cost = "800"
    @total_price = @order_details.sum{|order_detail|order_detail.subtotal}
    @total_payment = @order.shipping_cost + @total_price
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method)
  end 
end
