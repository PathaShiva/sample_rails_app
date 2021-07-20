class CreateServiceTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :service_types do |t|
      t.string :name, null: false
      t.string :details

      t.timestamps
    end
  end
end
