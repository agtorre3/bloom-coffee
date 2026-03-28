class Drink < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :base_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
