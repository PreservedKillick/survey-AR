class RemoveTimestamps < ActiveRecord::Migration
  def change
    change_table :surveys do |t|
      t.remove_timestamps
    end
    change_table :questions do |t|
      t.remove_timestamps
    end
    change_table :answers do |t|
      t.remove_timestamps
    end
    change_table :survey_takers do |t|
      t.remove_timestamps
    end
    change_table :taker_responses do |t|
      t.remove_timestamps
    end
  end
end
