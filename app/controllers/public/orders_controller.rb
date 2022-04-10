class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
    @order.shipping_cost = 800
    @total_price = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @total_payment = @order.shipping_cost + @total_price

    if params[:order][:postal_address] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:postal_address] == "2"
      @address = Address.find(params[:order][:selected_address])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items.all
      # カート内にある商品情報は複数あるため、一個ずつ処理していく
      @cart_items.each do |cart_item|
        # まず最初に取り出した一つの商品に関するテーブルをorder_detailsに作成する
        order_detail = OrderDetail.new
        # order_detailsが持つカラムにデータを代入していく
        # 注文ID
        order_detail.order_id = @order.id
        # 商品ID
        order_detail.item_id = cart_item.item_id
        # 購入時価格（税込）
        order_detail.price = cart_item.item.price
        # 数量
        order_detail.amount = cart_item.amount
        # order_detailsにデータを保存
        order_detail.save
      end
    @cart_items.destroy_all
    redirect_to public_orders_complete_path
  end

  def complete
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details.all
    @order.shipping_cost = 800
    @total_price = @order_detail.inject(0) { |sum, item| sum + item.subtotal }
    @total_payment = @order.shipping_cost + @total_price
  end
  
  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :shipping_cost)
  end
end