require "rails_helper"

RSpec.describe Order, type: :model do
  it "defaults to cart status" do
    expect(build(:order).status).to eq("cart")
  end

  it "supports submitted status" do
    expect(build(:order, :submitted).status).to eq("submitted")
  end

  describe "#total" do
    it "sums all order item line totals" do
      order = create(:order)
      drink_a = create(:drink, name: "Latte", base_price: 4.00)
      drink_b = create(:drink, name: "Mocha", base_price: 5.00)
      create(:order_item, order: order, drink: drink_a, quantity: 2)
      create(:order_item, order: order, drink: drink_b, quantity: 1)

      expect(order.total).to eq(13.00)
    end

    it "returns zero for an empty order" do
      expect(create(:order).total).to eq(0)
    end
  end

  describe "#item_count" do
    it "sums quantities across items" do
      order = create(:order)
      create(:order_item, order: order, quantity: 2)
      create(:order_item, order: order, quantity: 3)

      expect(order.item_count).to eq(5)
    end
  end
end
