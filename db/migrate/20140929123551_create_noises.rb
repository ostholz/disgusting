class CreateNoises < ActiveRecord::Migration
  def change
    create_table :noises do |t|
      t.string :name
      t.string :icon
      t.string :tag
      t.string :description


      t.timestamps
    end
  end
end
