User.create!(full_name:  "Example User",
             user_name:  "E.U.",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  full_name  = Faker::Name.name
  user_name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(full_name: full_name,
               user_name: user_name,
               email: email,
               password:              password,
               password_confirmation: password)
end