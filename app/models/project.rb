class Project < ApplicationRecord
  before_create :set_timestamps
  before_save :update_updated_at

  has_many :project_memberships
  has_many :users, through: :project_memberships
  has_many :tasks

  validates :name, presence: true
  validates :description, presence: true

  private

  def set_timestamps
    current_time = Time.current
    self.created_at ||= current_time
    self.updated_at ||= current_time
  end

  def update_updated_at
    self.updated_at = Time.current
  end
end
