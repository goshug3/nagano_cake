
[1mFrom:[0m /home/ec2-user/environment/nagano_cake/app/controllers/public/orders_controller.rb:31 Public::OrdersController#confirm:

    [1;34m28[0m: [32mdef[0m [1;34mconfirm[0m
    [1;34m29[0m:   @order = [1;34;4mOrder[0m.new(order_params)
    [1;34m30[0m:   binding.pry
 => [1;34m31[0m:   [32mif[0m params[[33m:order[0m][[33m:select_address[0m] == [31m[1;31m"[0m[31m0[1;31m"[0m[31m[0m
    [1;34m32[0m:     @order.postal_code = current_customer.postal_code
    [1;34m33[0m:     @order.address = current_customer.address
    [1;34m34[0m:     @order.name = current_customer.last_name + current_customer.first_name
    [1;34m35[0m:   [32melsif[0m params[[33m:order[0m][[33m:select_address[0m] == [31m[1;31m"[0m[31m1[1;31m"[0m[31m[0m
    [1;34m36[0m:     @address = [1;34;4mAddress[0m.find(params[[33m:order[0m][[33m:address_id[0m])
    [1;34m37[0m:     @order.postal_code = @address.postal_code
    [1;34m38[0m:     @order.address = @address.address
    [1;34m39[0m:     @order.name = @address.name
    [1;34m40[0m:   [32melsif[0m params[[33m:order[0m][[33m:select_address[0m] == [31m[1;31m"[0m[31m2[1;31m"[0m[31m[0m
    [1;34m41[0m:     address_new = current_customer.orders.new(order_params)
    [1;34m42[0m:     [32mif[0m address_new.save
    [1;34m43[0m:     [32melse[0m
    [1;34m44[0m:       render [33m:new[0m
    [1;34m45[0m:     [32mend[0m
    [1;34m46[0m:   [32melse[0m
    [1;34m47[0m:     render [33m:new[0m
    [1;34m48[0m:   [32mend[0m
    [1;34m49[0m:   @cart_items = current_customer.cart_items
    [1;34m50[0m:   @total_price = @cart_items.sum{|cart_item|cart_item.subtotal}
    [1;34m51[0m:   @order.shipping_cost = [31m[1;31m"[0m[31m800[1;31m"[0m[31m[0m
    [1;34m52[0m:   @order.total_payment = @order.shipping_cost + @total_price
    [1;34m53[0m: [32mend[0m

