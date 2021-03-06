class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def add?
    user.present? && (record.user == user)
  end

  def new?
    add?
  end

  def update?
    user.present? && (record.user == user)
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    record.class
  end
end

