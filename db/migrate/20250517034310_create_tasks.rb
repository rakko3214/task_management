class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :done, default: false
      t.date :due_date
      t.string :category

      t.timestamps
    end
  end
end
