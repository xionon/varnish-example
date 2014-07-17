class CreateSlowThings < ActiveRecord::Migration
  def change
    create_table :slow_things do |t|
      t.string :name

      t.timestamps
    end
  end
end
