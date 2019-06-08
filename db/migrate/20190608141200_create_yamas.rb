class CreateYamas < ActiveRecord::Migration[6.0]
  def change
    create_table :yamas do |t|
      t.string :name, { null: false }
      t.string :code, { null: false }
      t.integer :type, { null: false }

      t.timestamps
    end
  end
end
