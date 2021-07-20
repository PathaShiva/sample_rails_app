class CreatePackageUpdates < ActiveRecord::Migration[6.1]
  def change
    create_table :package_updates do |t|
      t.references :package, null: false, foreign_key: true
      t.string :location, null: false
      t.string :details

      t.timestamps
    end
  end
end
