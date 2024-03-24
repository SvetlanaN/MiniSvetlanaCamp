class TasksController < ApplicationController
  before_action :require_login
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    if params[:projectId]
      project = current_user.projects.find_by(id: params[:projectId])
      @tasks = project.tasks if project
    else
      @tasks = current_user.tasks
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find_by(id: params[:id])
    unless @task && current_user.projects.exists?(@task.project_id)
      flash[:error] = "The task doesn't exist or you don't have access to it"
      redirect_to projects_path
    end
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end

  # Only allow a list of trusted parameters through.
  def task_params
    # Ensure that the assigned_to_id belongs to a user who is an admin or an editor of the project
    params.require(:task).permit(:title, :description, :deadline, :status, :project_id, :assigned_to_id).tap do |whitelisted|
      project = Project.find_by(id: whitelisted[:project_id])
      if project
        assigned_to_id = whitelisted[:assigned_to_id]
        unless project.admins.exists?(assigned_to_id) || project.editors.exists?(assigned_to_id)
          whitelisted[:assigned_to_id] = nil
        end
      end
    end
  end
end
