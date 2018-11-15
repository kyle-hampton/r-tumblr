class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |table|
      table.string :first_name
      table.string :last_name
      table.string :username
      table.string :password
      table.string :email
      table.integer :birthday
    end
  end
end
