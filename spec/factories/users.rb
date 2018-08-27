FactoryBot.define do
  factory :user_old do
    first_name "Aaron"
    last_name  "Sumner"
    email "tester@example.com"
    password "dottle-nouveau-pavilion"
  end
  # シーケンスを使ってユニークバリデーションを持つフィールドを扱う
  factory :user, aliases: [:owner] do
    first_name "Aaron"
    last_name  "Sumner"
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "dottle-nouveau-pavilion"
  end
end
