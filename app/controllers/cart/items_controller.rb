class Cart::ItemsController < ApplicationController
  def create
    @order = current_order
    @order_item = @order.order_items.build(order_item_params)

    if @order_item.save
      save_add_ons(@order_item)
      redirect_to cart_path, notice: "#{@order_item.drink.name} added to your order."
    else
      redirect_to menu_path(@order_item.drink || Drink.first), alert: "Could not add item to order."
    end
  end

  def update
    @order_item = current_order.order_items.find(params[:id])
    new_quantity = params[:quantity].to_i

    if new_quantity > 0 && @order_item.update(quantity: new_quantity)
      redirect_to cart_path
    else
      redirect_to cart_path, alert: "Could not update quantity."
    end
  end

  def destroy
    @order_item = current_order.order_items.find(params[:id])
    @order_item.destroy!
    redirect_to cart_path, notice: "Item removed from your order."
  end

  private

  def order_item_params
    params.require(:order_item).permit(:drink_id, :quantity)
  end

  def save_add_ons(order_item)
    add_on_ids = Array(params[:order_item][:add_on_ids]).reject(&:blank?)
    return if add_on_ids.empty?

    AddOn.where(id: add_on_ids).find_each do |add_on|
      order_item.order_item_add_ons.create!(add_on: add_on)
    end
  end
end
