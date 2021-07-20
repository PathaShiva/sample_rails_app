# Create a main sample user.
User.create!(name:  "Admin User",
             email: "shiva17595@gmail.com",
             password:              "welcome@123",
             password_confirmation: "welcome@123",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)