
class TodoPolicy < ApplicationPolicy

  def index?
    user.present? && (record.user == user)
  end

  def create?
    user.present? && (record.user == user)
  end

  def update?
    create?
  end

  def new?
    @todo = Todo.new
    authorize @todo
  end
end
