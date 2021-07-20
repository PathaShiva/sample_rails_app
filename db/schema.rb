# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_18_180105) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "mobile"
    t.string "country"
    t.string "state"
    t.string "district"
    t.string "pincode"
    t.string "landmark"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "package_updates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "package_id", null: false
    t.string "location", null: false
    t.string "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["package_id"], name: "index_package_updates_on_package_id"
  end

  create_table "packages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "sender_address_id"
    t.string "sender_email"
    t.bigint "receiver_address_id"
    t.string "receiver_email"
    t.float "weight_of_parcel"
    t.float "cost"
    t.bigint "service_type_id", null: false
    t.column "payment_mode", "enum('COD','Prepaid')"
    t.bigint "status_id", null: false
    t.string "tracker_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receiver_address_id"], name: "fk_rails_25e0526609"
    t.index ["sender_address_id"], name: "fk_rails_c0d9c02ede"
    t.index ["service_type_id"], name: "index_packages_on_service_type_id"
    t.index ["status_id"], name: "index_packages_on_status_id"
    t.index ["user_id"], name: "index_packages_on_user_id"
  end

  create_table "service_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", limit: 100, null: false
    t.string "password_digest", null: false
    t.string "remember_digest"
    t.boolean "admin"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "package_updates", "packages"
  add_foreign_key "packages", "addresses", column: "receiver_address_id"
  add_foreign_key "packages", "addresses", column: "sender_address_id"
  add_foreign_key "packages", "service_types"
  add_foreign_key "packages", "statuses"
  add_foreign_key "packages", "users"
end
