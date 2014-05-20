class TodosController < ApplicationController
  def index
    @todos = Todo.all
    @new_todo=Todo.new

  end

  def new
    @todo = Todo.new
    authorize @todo
  end

  def show
    @todo = todo.find(params[:id])
    authorize @todo
  end

  def add
   todo = Todo.create(:descripton => params[:todo][:descripton])
   unless todo.valid?
     flash[:error] = todo.errors.full_messages.join("<br>").html_safe
   else
     #set flash[:success] to "Todo added successfully"   
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
    params.require(:todo).permit(:description)
  end

end