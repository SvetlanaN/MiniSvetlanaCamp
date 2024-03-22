class ChangeColumnNullability < ActiveRecord::Migration[7.1]
  def change
    change_column_null :projects, :start_date, true
    change_column_null :projects, :end_date, true
    change_column_null :tasks, :deadline, true
    change_column_null :tasks, :assigned_to_id, true
  end
end
