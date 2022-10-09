class ChangeOnlineToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :online, :boolean, default: false, null: false
  end
end
