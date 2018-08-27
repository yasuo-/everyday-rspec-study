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
    User.create(
      first_name: "Ken",
      last_name:  "Tester",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion",
    )
    user = User.new(
      first_name: "Ken",
      last_name:  "Tester",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion",
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  # フルネームが出力メソッドのテスト
  it "returns a user's full name as a string" do
    user = User.new(
      first_name: "Ken",
      last_name:  "Tester",
      email:      "tester@example.com", 
    )
    expect(user.name).to eq "Ken Tester"
  end
end
