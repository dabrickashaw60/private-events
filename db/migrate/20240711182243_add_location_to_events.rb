class AddLocationToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :locatocation, :string
  end
end
