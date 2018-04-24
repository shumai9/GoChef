class Image < ApplicationRecord
  require 'carrierwave/orm/activerecord'
  mount_uploader :picture, ImageUploader
  belongs_to :user

end
