class Order < ApplicationRecord
  belongs_to :order_status
  has_many :order_guides
  before_create :set_order_status
  before_save :update_subtotal


  def subtotal
    order_guides.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end
private
  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end

end
