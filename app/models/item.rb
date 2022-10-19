class Item < ApplicationRecord
  validates :item_name, :item_description, :item_price, :image, presence: true
  validates_inclusion_of :item_price, in: 300..9999999
  validates_format_of :item_price, with: /\A[0-9]+\z/

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
