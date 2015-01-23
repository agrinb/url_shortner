class ChangeColumnsInUrls < ActiveRecord::Migration
  def change
  	add_column :urls, :code, :string
  end
end
