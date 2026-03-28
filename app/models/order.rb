class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  enum :status, { cart: 0, submitted: 1 }

  validates :customer_name, presence: true, if: :submitted?

  def total
    order_items
      .joins(:drink)
      .left_joins(:add_ons)
      .sum("(drinks.base_price + COALESCE(add_ons.price, 0)) * order_items.quantity")
  end

  def item_count
    order_items.sum(:quantity)
  end

  def order_number
    "##{id}"
  end
end
