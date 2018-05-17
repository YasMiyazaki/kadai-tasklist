class TasksController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  include SessionsHelper  

  def index
    if logged_in?
  #    @user = current_user
  #    @task = current_user.task.build #form_for用
  #    @tasks = curent_user.tasks.order('created_at DESC').page(params[:page])
    @tasks = current_user.tasks.all
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが登録されませんでした'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id]) 
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end

  private
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status, :users)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end


end
