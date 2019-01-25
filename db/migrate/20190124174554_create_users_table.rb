class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :email
      t.datetime :birthday
      t.string :password
      t.datetime :date_created
    end


    create_table :posts do |t|
      t.string :content
      t.string :image_url
      t.integer :user_id
      t.string :title
      t.datetime :datetime
      t.datetime :date_created
    end

    
  end
end