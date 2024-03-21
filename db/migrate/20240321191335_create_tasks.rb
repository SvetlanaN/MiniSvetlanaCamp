class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :status, default: 0, null: false # 0: in_backlog, 1: done, 2: in_progress
      t.date :deadline, null: false
      t.references :project, foreign_key: true, null: false
      t.references :assigned_to, foreign_key: { to_table: :users }, null: false
      t.timestamps null: false
    end
  end
end
