class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:page]).order(created_at: :desc)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer.id)
  end 
  
  private
  
  def customer_params
    params.recuire(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number, :is_active, :email)
  end 
end
