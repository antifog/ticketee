class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
    end

	add_column :tickets, :state_id, :integer
    add_index :tickets, :state_id

  end
end
