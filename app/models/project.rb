class Project < ApplicationRecord
  has_many :project_memberships
  has_many :users, through: :project_memberships
  has_many :tasks

  validates :name, presence: true
end
