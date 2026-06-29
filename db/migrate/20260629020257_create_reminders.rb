class CreateReminders < ActiveRecord::Migration[8.1]
  def change
    create_table :reminders do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :message
      t.datetime :remind_at
      t.boolean :done

      t.timestamps
    end
  end
end
