class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.date :dob
      t.string :picture
      t.string :role
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
