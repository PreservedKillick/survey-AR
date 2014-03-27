class EditTables < ActiveRecord::Migration
  def change
    remove_column :survey_takers, :answer_id, :int

    create_table :taker_responses do |t|
      t.column :answer_id, :int
      t.column :survey_taker_id, :int

      t.timestamps
    end
  end
end
