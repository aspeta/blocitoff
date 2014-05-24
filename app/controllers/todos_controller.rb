class TodosController < ApplicationController
  def index
    @todos  = current_user.todos
    @new_todo=Todo.new
  end

  def new
    @todo = Todo.new
    authorize @todo
  end

  def destroy
    @todo =current_user.todos
    if todo.created_at > 7.days 
      flash[:success]= "Delete the 7 day or older tasks"
    else
      flash[:error] = "No task to delete that is older than 7 days!"
    end
    redirect_to :action => 'index'
  end
  def show
    @todo = todo.find(params[:id])
    authorize @todo
  end

  def add
    todo = current_user.todos.build(descripton: params[:todo][:descripton])
    #todo = Todo.create(:descripton => params[:todo][:descripton])
    if todo.save
      flash[:success] = "Todo added successfully"
    else  
     flash[:error] = todo.errors.full_messages.join("<br>").html_safe
    end
    redirect_to :action => 'index'
  end

  def edit
    @todo = todo.find(params[:id])
    authorize @todo
  end

#  def create
#    @todo = todo.new(todo_params)
#    authorize @todo
#    if @todo.save
#      redirect_to @todo, notice: "todo was saved successfully."
#    else
#      flash[:error] = "Error creating todo. Please try again."
#      render :new
#    end
#  end

  def update
    @todo = todo.find(params[:id])
    authorize @todo
    if @todo.update_attributes(todo_params)
      redirect_to @todo
    else
      flash[:error] = "Error saving todo. Please try again"
      render :edit
    end
  end

  def complete
     params[:todos_checkbox].each do |check|
       todo_id = check
     t = Todo.find_by_id(todo_id)
         t.update_attribute(:completed, true)
     end
    redirect_to :action => 'index'

  end 


  private

  def todo_params
    params.require(:todo).permit(:descripton)#, :user_id)
  end

end