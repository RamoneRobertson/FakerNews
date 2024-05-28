class AddDateToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :date, :datetime, null: false
  end
end
