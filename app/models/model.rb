class Like < ApplicationRecord
  validates_uniqueness_of :chef, scope: :recipe

  belongs_to :chef
  belongs_to :recipe
end