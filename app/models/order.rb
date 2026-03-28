class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  enum :status, { cart: 0, submitted: 1 }

  def total
    order_items.sum(&:line_total)
  end

  def item_count
    order_items.sum(:quantity)
  end
end
