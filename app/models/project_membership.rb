class ProjectMembership < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum role_type: { admin: 0, editor: 1, viewer: 2 }

  validates :role_type, presence: true
end
