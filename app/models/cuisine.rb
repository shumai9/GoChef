class Cuisine < ApplicationRecord
  has_many :skillsets
  has_many :users, through: :skillsets
end
