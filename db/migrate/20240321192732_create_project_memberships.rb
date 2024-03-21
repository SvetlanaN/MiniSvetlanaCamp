class CreateProjectMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :project_memberships do |t|
      t.references :user, foreign_key: true, null: false
      t.references :project, foreign_key: true, null: false
      t.integer :role_type, null: false # 0: admin, 1: editor, 2: viewer
      t.timestamps null: false
    end
  end
end
