class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :mobile
      t.string :country
      t.string :state
      t.string :district
      t.string :pincode
      t.string :landmark

      t.timestamps
    end
  end
end
