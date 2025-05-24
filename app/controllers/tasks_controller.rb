class TasksController < ApplicationController
  before_action :set_task, only: %i[ destroy ]

  def index
    @tasks = Task.all
  end

  def toggle_done
    @task = Task.find(params[:id])
    @task.update(done: !@task.done)
    @tasks = Task.all
  
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tasks_path, notice: "タスクの状態を変更しました。" }
    end
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        @tasks = Task.all
        format.turbo_stream
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("task_form", partial: "tasks/form", locals: { task: @task }) }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end  

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to tasks_path, status: :see_other, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :due_date, :category)
    end
end
