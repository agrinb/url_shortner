class AddUserRefToUrls < ActiveRecord::Migration
  def change
    add_reference :urls, :user, index: true
    add_index :urls, :old_url
  end
end
