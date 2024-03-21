class User < ApplicationRecord
    has_many :project_memberships
    has_many :projects, through: :project_memberships
    has_many :tasks, foreign_key: :assigned_to_id
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true
  end
  