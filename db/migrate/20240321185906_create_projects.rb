class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps null: false
    end
  end
end
