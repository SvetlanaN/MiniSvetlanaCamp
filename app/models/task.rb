class Task < ApplicationRecord
  belongs_to :project
  belongs_to :assigned_to, class_name: "User"

  enum status: { in_backlog: 0, done: 1, in_progress: 2 }

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :deadline, presence: true
end
