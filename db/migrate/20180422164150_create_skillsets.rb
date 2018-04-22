class CreateSkillsets < ActiveRecord::Migration[5.1]
  def change
    create_table :skillsets do |t|
      t.references :user, foreign_key: true
      t.references :cuisine, foreign_key: true

      t.timestamps
    end
  end
end
