class Public::CustomersController < ApplicationController

  def show
  end

  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    redirect_to customers_path
  end

  def unsubscribe
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :email, :telephone_number)
  end

end

