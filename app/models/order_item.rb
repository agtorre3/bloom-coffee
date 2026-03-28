class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :drink
  has_many :order_item_add_ons, dependent: :destroy
  has_many :add_ons, through: :order_item_add_ons

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def unit_price
    drink.base_price + add_ons.sum(:price)
  end

  def line_total
    unit_price * quantity
  end
end
