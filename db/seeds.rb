# Clear existing data
ProjectMembership.destroy_all
Task.destroy_all
Project.destroy_all
User.destroy_all

# Create new data
# Creating example projects
project1 = Project.create(name: "Project 1", description: "Description for Project 1", start_date: Date.today, end_date: Date.today + 30.days)
project2 = Project.create(name: "Project 2", description: "Description for Project 2", start_date: Date.today, end_date: Date.today + 45.days)
project3 = Project.create(name: "Project 3", description: "Description for Project 3", start_date: Date.today, end_date: Date.today + 60.days)

# Creating example users
user1 = User.create(name: "User 1", email: "user1@example.com", password_digest: BCrypt::Password.create("password1"))
user2 = User.create(name: "User 2", email: "user2@example.com", password_digest: BCrypt::Password.create("password2"))
user3 = User.create(name: "User 3", email: "user3@example.com", password_digest: BCrypt::Password.create("password3"))
user4 = User.create(name: "User 4", email: "user4@example.com", password_digest: BCrypt::Password.create("password4"))
user5 = User.create(name: "User 5", email: "user5@example.com", password_digest: BCrypt::Password.create("password5"), roles: ['sys_admin'])

# Creating project memberships
# Project 1
ProjectMembership.create(user_id: user1.id, project_id: project1.id, role_type: :admin)
ProjectMembership.create(user_id: user4.id, project_id: project1.id, role_type: :editor)
# Project 2
ProjectMembership.create(user_id: user2.id, project_id: project2.id, role_type: :admin)
ProjectMembership.create(user_id: user1.id, project_id: project2.id, role_type: :editor)
ProjectMembership.create(user_id: user4.id, project_id: project2.id, role_type: :viewer)
# Project 3
ProjectMembership.create(user_id: user3.id, project_id: project3.id, role_type: :admin)
ProjectMembership.create(user_id: user1.id, project_id: project3.id, role_type: :viewer)

# Creating example tasks
Task.create(title: "Task 1", description: "Description for Task 1", status: :in_backlog, deadline: Date.today + 10.days, project_id: project1.id, assigned_to_id: user1.id)
Task.create(title: "Task 2", description: "Description for Task 2", status: :in_progress, deadline: Date.today + 20.days, project_id: project2.id, assigned_to_id: user2.id)
Task.create(title: "Task 3", description: "Description for Task 3", status: :done, deadline: Date.today + 15.days, project_id: project3.id, assigned_to_id: user3.id)

puts "Seeds generated successfully."
