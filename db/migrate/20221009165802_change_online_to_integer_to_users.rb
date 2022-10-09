class ChangeOnlineToIntegerToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :online, :integer, default: 0, null: false
  end
end
