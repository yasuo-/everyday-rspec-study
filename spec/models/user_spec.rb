require 'rails_helper'

RSpec.describe User, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 姓、名、メール、パスワードがあれば有効な状態であること
  it "is valid with a first name, last name, email, and password" do
    user = User.new(
      first_name: 'Aaron',
      last_name: 'Summer',
      email: 'tester@example.com',
      password: 'dottle-nouveau-pavilion-tights-furze',
    )
    expect(user).to be_valid
  end

  # 名がなければ無効な状態であること
  it "is invalid without a first name" do
    # 今回は新しく作ったユーザー(first_name には明示的に nil をセットします)
    user = FactoryBot.build(:user, first_name: nil)
    # valid? メソッドを呼び出すと有効(valid)に ならず
    user.valid?
    # ユーザーの first_name 属性にエラーメッセージが付いて いることを 期待(expect) します
    expect(user.errors[:first_name]).to include("can't be blank")
  end
  # 性がなければ無効な状態であること
  it "is invalid without a last name" do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: "aaron@example.com")
    user = FactoryBot.build(:user, email: "aaron@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  # フルネームが出力メソッドのテスト
  it "returns a user's full name as a string" do
    user = FactoryBot.build(:user, first_name: "Ken", last_name: "Tester")
    expect(user.name).to eq "Ken Tester"
  end

  # エラーになる（明示的に異なる値を設定しない限り、ファクト リが常にユーザーのメールアドレスを tester@example.com に設定する）
  # 複数のユーザーで何かする
  it "does something with multiple users" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    expect(true).to be_truthy
  end
  # シーケンスを使ってユニークバリデーションを持つフィールドを扱う
end
