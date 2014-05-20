class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :descripton
      t.boolean :completed
      
      t.timestamps
    end
  end
end
