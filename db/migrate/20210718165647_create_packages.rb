class CreatePackages < ActiveRecord::Migration[6.1]
  def change
    create_table :packages do |t|
      t.bigint :sender_address_id
      t.string :sender_email
      t.bigint :receiver_address_id
      t.string :receiver_email
      t.float :weight_of_parcel
      t.float :cost
      t.references :service_type, null: false, foreign_key: true
      t.column :payment_mode, "enum('COD','Prepaid')"
      t.references :status, null: false, foreign_key: true
      t.string :tracker_id, null: false,unique: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_foreign_key :packages, :addresses, column: :sender_address_id
    add_foreign_key :packages, :addresses, column: :receiver_address_id
  end
end
