class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:page])
  end

  def show
  end

  def edit
  end
  
  private
  
  def customer_params
    params.recuire(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number, :is_active, :email)
  end 
end
