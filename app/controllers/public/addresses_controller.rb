class Public::AddressesController < ApplicationController
  def index
    @address = current_customer.addresses.new
    @addresses = current_customer.addresses.all
  end
  
  def create
    @addresses = current_customer.addresses.all
    @address = current_customer.addresses.new(address_params)
    @address.save
    redirect_to public_addresses_path
  end

  def edit
    @address = current_customer.addresses.find(params[:id])
  end
  
  def update
    @address = current_customer.addresses.find(params[:id])
    @address.update(address_params)
    redirect_to public_addresses_path
  end
  
  def destroy
    @address = current_customer.addresses.find(params[:id])
    @address.destroy
    redirect_to public_addresses_path
  end
  
  private
  
  def address_params
    params.require(:address).permit(:name, :postal_code, :address, :customer_id)
  end
end
