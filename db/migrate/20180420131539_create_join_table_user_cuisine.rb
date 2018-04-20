class CreateJoinTableUserCuisine < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :cuisines do |t|
      # t.index [:user_id, :cuisine_id]
      # t.index [:cuisine_id, :user_id]
    end
  end
end
