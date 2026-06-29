class CreateCustomers < ActiveRecord::Migration[8.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phone
      t.integer :status
      t.text :notes
      t.date :last_contact_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
