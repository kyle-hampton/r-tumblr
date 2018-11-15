class CreateBlogsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |table|
      table.string :title
      table.string :content
    end
  end
end
