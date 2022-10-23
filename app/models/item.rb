class Item < ApplicationRecord
  validates :item_name, :item_description, :item_price, :image, presence: true
  validates :item_price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :item_name, length: {maximum: 40}
  validates :item_description, length: {maximum: 1000}

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :delivery_cost
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :delivery_date
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_status

  validates :category_id, :item_status_id, :delivery_cost_id, :delivery_date_id, :prefecture_id, numericality: { other_than: 1 , message: "can't be blank" }
end
