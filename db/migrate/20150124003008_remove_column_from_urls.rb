class RemoveColumnFromUrls < ActiveRecord::Migration
  def change
  	remove_column :urls, :user_id
  end
end
