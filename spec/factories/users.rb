FactoryBot.define do
  factory :user do
    name { 'テストユーザーA'}
    email { 'a@example.com'}
    password  { 'password' }
  end
end
