
FactoryBot.define do
  factory :task do
    name { 'テストを書く'}
    decription { 'RSpec&Capybara%FactoryBotを準備する'}
    user
  end
end
