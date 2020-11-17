class DeleteNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name, String
  end
end
