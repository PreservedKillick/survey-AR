class EditQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :name, :string

    add_column :questions, :query, :string
  end
end
