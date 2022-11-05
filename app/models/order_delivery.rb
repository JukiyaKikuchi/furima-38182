class OrderDelivery
  include ActiveModel::Model
  attr_accessor :postcode, :city, :address, :building, :tell_number, :prefecture_id, :user_id, :item_id, :token

  with_options presence: true do
    validates :user_id, :item_id, :city, :address, :token
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :tell_number, format: {with:/\A\d{10,11}\z/}
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Delivery.create(postcode: postcode, city: city, address: address, building: building, tell_number: tell_number, prefecture_id: prefecture_id, order_id: order.id)
  end
end