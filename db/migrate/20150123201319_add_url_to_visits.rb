class AddUrlToVisits < ActiveRecord::Migration
  def change
  	add_column :visits, :old_url, :string
  end
end
