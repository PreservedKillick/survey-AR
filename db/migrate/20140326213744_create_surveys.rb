class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.column :title, :string

      t.timestamps
    end
  end
end
