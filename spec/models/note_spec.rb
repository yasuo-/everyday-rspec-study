require 'rails_helper'

RSpec.describe Note, type: :model do
  # ファクトリで関連するデータを生成する
  it "generates associated data from a factory" do
    note = FactoryBot.create(:note)
    # puts "This note's propject is #{note.project.inspect}"
    # puts "This note's user is #{note.user.inspect}"
  end

  before do
    # このファイルの全テストで使用するテストデータをセットアップする.
    # before ブロックの中に書かれたコード は内側の各テストが実行される前に実行されます
    @user = User.create(
      first_name: "Ken",
      last_name:  "Tester",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion",
    )

    @project = @user.projects.create(
      name: "Test Project",      
    )
  end
  
  # バリデーション用のスペックが並ぶ
  
  # ユーザー、プロジェクト、メッセージがあれば有効な状態であること
  it "is valid with a user, project, and message" do
    note = Note.new(
      message: "This is a sample note.",
      user: @user,
      project: @project,
    )
    expect(note).to be_valid
  end

  # メッセージがなければ無効な状態であること
  it "is invalid without a message" do
    note = Note.new(message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end
  
  # 文字列に一致するメッセージを検索する
  describe "search message for a term" do
    # 検索用のexampleが並ぶ

    before do
      # 検索機能の全テストに関連する追加のテストデータをセットアップする。
      # 検索用のexampleが動く前に呼ばれる
      @note1 = @project.notes.create(
        message: "This is the first note.",
        user: @user,                
      )
      @note2 = @project.notes.create(
        message: "This is the second note.",
        user: @user,                
      )
      @note3 = @project.notes.create(
        message: "First, preheat the oven.",
        user: @user,               
      )
    end

    # 一致するデータが見つかる時
    context "when a match is found" do
      # 一致する場合のexampleが並ぶ...
      it "returns notes that match the serch term" do
        expect(Note.search("first")).to include(@note1, @note3)
      end
    end

    # 一致するデータが１件も見つからない時
    context "when no match is found" do
      # 一致しない場合のexampleが並ぶ...
      # 空のコレクションを返すこと
      it "returns an empty collection" do
        expect(Note.search("message")).to be_empty
      end
    end
  end
end
