class EditAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :selection, :string
  end
end
