# README

Markdown記法で書いてみよう プログラミング学習共有サイト
====
## 概要

オンライン学習において、Gitを用いた共同開発で作成した、Qiita のクローンアプリです。
https://stark-badlands-95573.herokuapp.com/
ログイン用サンプルユーザー: email: sample@example.com, password: password

### System dependencies
- Ruby version 2.6.3
- vue version 2.6.11

### 機能一覧
- ユーザー登録、ログイン、ログアウト
- 下書き投稿、本番公開投稿(Markdown記法)
- 記事一覧表示
- 記事編集、削除（フロント側実装中）
- マイページ一覧表示（本番公開記事のみ）
- 下書き一覧表示（自身の記事のみ）

API は Rails、フロントは Vue で作成しました。
※ Vueは、サンプルコードを利用している為、自分で実装はしていません。

model、API のテスト（Rspec）を実装し、heroku へのデプロイを行いました。

## スクリーンショット
<img width="1382" alt="スクリーンショット 2020-01-22 2 32 46" src="https://user-images.githubusercontent.com/50073648/72861456-5188a400-3d0d-11ea-97f4-f13a280b4e35.png">

<img width="1370" alt="スクリーンショット 2020-01-22 11 49 30" src="https://user-images.githubusercontent.com/50073648/72861461-551c2b00-3d0d-11ea-85e3-7b2342c334b1.png">

