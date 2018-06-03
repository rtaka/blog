---
title: JJUG CCC 2018 Spring
date: "2018-06-02"
---

## 概要
* 日本 Java ユーザグループ主催のコミュニティカンファレンス
* 2018/5/26 Sat 10:00 - 18:30
* ベルサール新宿グランド コンファレンスセンター 5F

## Java で Web サービスを作り続けるための戦略と戦術
* 開発環境とは、プログラマ以外のデザイナ、サービス側などのエンジニア以外も使う
* 開発、検証環境が動かない → 別バージョンのアプリがデプロイされているとか
* 開発手順書じゃなくて、セットアップを自動化する
* サービスごとに VM を作って、その上に Docker でアプリ、DB を稼働させる
    * Docker For Mac を使わなかった理由
        * 当時、動作が不安定だったので
        * ローカルホストのポートが重複するので
* Docker の作成、運用はアプリケーションエンジニアの仕事
* Maven から Gradleに移行
    * 並列ビルド
    * xml はもう古い
* Jenkins 2 の Jenkinsfile にビルド定義を書く
* プルリクごとに開発/検証環境を用意できることが理想
    * サービスが側にすぐ確認してもらえるように
* Tomcat はインストールして eclipse から起動するのではなく、new Tomcat() する
* JasperReport はオワコン
    * Java 8 だとデザインツールが事実上動かない(2016 年当時)
* JSESSIONID はオワコン
    * 複数のアプリを起動すると、競合するので
    * 名前はアプリごとに変更可能
    * sticky-session-cookie もオワコン
        * spring-session-... でラップすればよい
* src/main/webapp じゃなく src/main/resources におく

## Java 9 Variable Handles のイロハ
* Valhalla の由来
    * Valhalla == VALue types に似ているから
* ライブラリ、フレームワーク開発者が主に使う機能
    * Java 10 から
    * sun.misc.Unsafe の代わりに使う
* sun.misc.Unsafe
    * JDK の内部インターフェース API
    * 直接メモリを操作可能
    * Reflection, Serializaion, NIO 等の実装で使用
    * Sun(Oracle) 以外の利用は想定外
        * 通常の開発で使うことはない
* Variable Handles
    * データ単位ではなくアクセス単位でメモリ操作可能
    * Java 9 まではアトミックな処理で unsafe を使うことがあった
    * Java 10 以降は、 Var Handle を使う
* MethodHandle
    * VarHandle の前提知識
    * メソッドのポインタ
    * 関数ポインタ
    * Reflection API の代替手段になる(パフォーマンスがよくなる事例がある)
    * Field のアクセス、例外 throw、定数を返すとかできる
    * セキュリティチェックが発生しない
        * チェックするオーバーヘッドを削減できる
        * 脆弱性になることがある
* volatile → ボラティルって発音してた

## LINE LIVE のチャットが 30,000+/min のコメント投稿をさばけるようになるまで
* WebSocket
    * LINE LIVE チャットでは送信文字数が少ないので REST API をいちいち呼び出すと思い
* akka Actor Model
    * actor に大きな処理をさせない(小さく分割することが重要)
    * ブロッキングする処理をさせない
    * All for One strategy
        * 複数の子 actor を持っている場合に有用
        * 各アクター間の依存度が高く、crash したら他のアクターも失敗させることができる

## Java から TypeScript へ 切り替えて加速するサーバーレス開発
* AWS Lambda を TypeScript で開発した話
* Lambda を使うとサーバの管理、メンテは不要になるので楽
* ランタイムが Java でコールドスタートした場合、遅いので Node.js にした
* Java 開発者だったら素の JavaScript じゃなくて TypeScript 使うと型の恩恵を受けられていい
* Lambda がチェーンしているアーキテクチャがちょっと失敗だったかも
    * 各 Lambda がコールドスタートになるとかなり遅くなる

## DDDとクリーンアーキテクチャでサーバーアプリケーションを作っている話
* 作ったアプリケーションが密結合、ビジネスロジックを書くドメイン層がなかった
* DDD、クリーンアーキテクチャで作り直している

## 感想
* フレームワークは Spring が主流な感じだった
* Docker 使うのはもう当たり前な感じ
* 聞いているだけだったけど、最後は疲れちゃってメモが雑に、、、

## スライド
* [こちら](http://d.hatena.ne.jp/chiheisen/20180527/1527375138)のブログにいい感じでリンクが貼ってあります
