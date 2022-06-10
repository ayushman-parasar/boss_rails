class AddDescriptionAndCreatedAtToDepartments < ActiveRecord::Migration[7.0]
  def change
    add_column :departments, :description, :string
    add_column :departments, :first_created_at, :string
  end
end
