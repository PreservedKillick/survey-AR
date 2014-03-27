class CreateSurveyTakers < ActiveRecord::Migration
  def change
    create_table :survey_takers do |t|
      t.column :name, :string
      t.column :answer_id, :int

      t.timestamps
    end
  end
end
