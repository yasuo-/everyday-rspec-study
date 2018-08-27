FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Test Project #{n}" }
    description "A test project."
    due_on 1.week.from_now
    association :owner

    # ------------ ▼継承して重複をスッキリさせる ------------
    # 昨日が締め切りのプロジェクト
    factory :project_due_yesterday do
      due_on 1.day.ago
    end

    # 今日が締め切りのプロジェクト
    factory :project_due_today do
      due_on Date.current.in_time_zone
    end

    # 明日が締め切りのプロジェクト
    factory :project_due_tomorrow do
      due_on 1.day.from_now
    end
  end

  # ------------ ▼ひとつひとつ作成 ------------
  # 昨日が締め切りのプロジェクト
  factory :project_due_yesterday_old, class: Project do
    sequence(:name) { |n| "Test Project #{n}" }
    description "A test project."
    due_on 1.day.ago
    association :owner
  end

  # 今日が締め切りのプロジェクト
  factory :project_due_today_old, class: Project do
    sequence(:name) { |n| "Test Project #{n}" }
    description "A test project."
    due_on Date.current.in_time_zone
    association :owner
  end

  # 明日が締め切りのプロジェクト
  factory :project_due_tomorrow_old, class: Project do
    sequence(:name) { |n| "Test Project #{n}" }
    description "A test project."
    due_on 1.day.from_now
    association :owner
  end
end
