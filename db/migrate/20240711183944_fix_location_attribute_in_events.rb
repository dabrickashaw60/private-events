class FixLocationAttributeInEvents < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :locatocation, :string if column_exists?(:events, :locatocation)
    add_column :events, :location, :string unless column_exists?(:events, :location)    
  end
end
