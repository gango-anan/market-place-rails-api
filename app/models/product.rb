class Product < ApplicationRecord
  validates :title, :user_id, presence: true
  validates :price, numericality: { greater_than_or_eqaul_to: 0 }, presence: true
  belongs_to :user
end
