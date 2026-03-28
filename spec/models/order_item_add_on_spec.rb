require "rails_helper"

RSpec.describe OrderItemAddOn, type: :model do
  it "belongs to an order item and an add-on" do
    association = build(:order_item_add_on)
    expect(association).to be_valid
    expect(association.order_item).to be_present
    expect(association.add_on).to be_present
  end
end
