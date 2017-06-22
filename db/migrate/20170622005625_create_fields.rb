class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.references :sub_category, index: true
      t.integer :order
      t.string :title
      t.string :type
      t.string :values

      t.timestamps null: false
    end
    add_foreign_key :fields, :sub_categories
  end
end
