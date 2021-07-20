class CreateAdminUsers < ActiveRecord::Migration[6.0]

    def change
      u = User.new(name: "Patha Shiva Kumar", email: "shiva17595@gmail.com", password: "welcome@123",password_confirmation: "welcome@123",admin: true,activated: true,activated_at: Time.zone.now)
      u.save!
    end
  end
  