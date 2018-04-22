class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def as_json
    {id: id, name: name, location_lat:location_lat, location_lon: location_lon, radius: radius}
  end
end
