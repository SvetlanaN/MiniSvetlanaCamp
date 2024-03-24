class User < ApplicationRecord
  has_many :project_memberships
  has_many :projects, through: :project_memberships
  has_many :tasks, foreign_key: :assigned_to_id

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  serialize :roles, JSON

  ROLES = ['sys_admin'].freeze # Currently only sys_admin role is supported

  validate :validate_roles

  def roles=(value)
    super(value.reject(&:blank?))
  end

  def roles
    super || []
  end

  def has_role?(role)
    roles.include?(role.to_s)
  end

  private

  def validate_roles
    unless roles.all? { |role| ROLES.include?(role) }
      errors.add(:roles, "can only be #{ROLES.join(', ')}")
    end
  end
end
