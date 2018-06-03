---
title: Java Day Tokyo 2018
date: "2018-06-02"
---

## 概要
* 日本オラクル主催のカンファレンス
* 2018/5/17 Thu 9:00 - 18:00
* シェラトン都ホテル東京

## Java in a World of Containers
* Java in a World of Containers
  * Security が重要
  * ハードウェア、コンテナの設定が混在している
  * Java は JVM による非依存性が高い
    * リッチなエコシステムがある
* Creating Docker images
  * docker run はインスタンス化
* Creating Custom JREs
  * JRE を全部入りで構成すると 600 MB ぐらいになる
  * JDK 9 の Module システムでカスタム JRE を作成できる
    * jlink を使える
    * JDK 9 , Module 化されていないくても jlink を使える
    * 必要なモジュール一覧がわからない場合、jdeps を使えばよい
* Optimizing Image Size
  * Full JDK 600 MB
  * base 46 MB
  * netty 60 MB
    * ミニマルなサイズ縮小が可能
  * 静的なアプリの場合、サイズの最適化はあまり重要でない
  * Docker ベースイメージの最適化には -slim , alpine linux を使う
  * alpine linux musl を使う
    * Portola　でベースイメージ 4 MB
  * Sharing Across Instances
  * OS Shared library
    * Class Data Sharing
      * インスタンス間でのクラス共有で起動時間の改善
* Java + Docker features
  * JVM は C グループ、ネームスペースをみるので実行環境は意識しない
  * --cpuset-cpus (JDK 9)
  * --cpu-quota (JDK 10)
  * Runtime.availableProcessors(), ForkJoin pool, VM internal thread pools で Docker の設定が効く
  * Memory settings (JDK 10)
    * -m<size>
    * java heap size, GC region sizes, etc...
* Summary
  * Docker イメージを JDK フルで作ると 800 MB
  * 最適化すると 38 MB ぐらいに縮小できる
  * Docker のリソース制限が java でも有効になる

## Java 開発者に贈るコンテナ時代のデプロイメントパイプライン
* コンテナで作られたアプリとデプロイメントパイプラインは好相性
* プロダクトに関わる全ての人にパイプラインのメトリクスを共有するべし
  * 開発者以外もプロダクトの状況を把握してもらえる
* 役割の決まっているチームでの導入
  * それぞれが使っているツールのことまでは分からない
  * お互いのことが分からないと、自己防衛の為に見積もりを過大に評価しがち
  * 技術的負債の可視化をしていないと、根性で対応
    * -> 孤独な開発社になる(サイロ化)
* サイロ化された組織は部分最適化に陥りがち
* デプロイメントパイプラインを始めるポイント
  * バリューストリームマッピングから始める
  * プロセスを短く、最適化することを検討
    * ステークホルダー、権限がある人を巻き込んで行う
  * 複雑なまま自動化しない(重要)
* テスト環境へのデプロイまでのリードタイムが長い
  * 環境構築を開発者で行う
* 本番環境へのデプロイまでのリードタイムが長い
  * 息の長い feature ブランチがあるとマージに手間取る -> リードタイムが長くなる
  * トランクベースで開発を行うとマージが簡単になるので、リードタイムを縮小できる
    * リリースとデプロイを分離する
      * ブルーグリーンデプロイ
    * トランクベース開発の方がプロセスが簡単になる

## Java in Serverless Land
* Java は、Serverless 環境での人気は 3 番目
* 企業の規模が大きくなってくると Java shop になる
  * Java は成熟している
* 複雑なドメインの問題は fn flow で対応
  * コードでワークフローを表現できる
  * テスト可能、型安全
  * CompletionState API と Fn Flow は似ている
* サーバーレス環境(fn project)で JVN を効率的に使用できるのか
  * 起動が早い、イメージが小さい、環境設定が尊重されること
  * メモリ共有(Share memory)で起動が早くなる
    * Shared images layers -> Shared memory
    * libc libjava.so
  * CDS
    * 起動の初期化処理を事前に行っておく、Class Data Sharing で起動の高速化が可能
  * AppCDS
    * JDK 10
    * たくさんクラスがある場合は、効果がある
  * AOT
  * OSイメージの最小化
    * Project Portola
  * JDK
    * jlink を使って必要最小限の JDK を作る
  * Application code
    * 最小の依存性で作る
    * jlink で整理できる
  * JVM
    * SubstrateVM 新しい軽量の VM が Oracle Labs から発表された
  * JVM エルゴノミクス
    * 利用可能なリソースからメモリ、CPU の使用量を自動で割り当ててくれる

## Java 最新開発ツール事情
* 侍
  * スレッドダンプの解析ツール
* 単体テストで使う DB は Docker 上で MySQL を動かしている
* コード内で日本語を使うの推進派
  * ビジネス用語を翻訳せずにそのまま使った方が可読性が上がる
* YouTrack
  * 課題管理ツール
  * 10 名まで無料
  * IntelliJ から作業するチケットの状態を変更できる
    * ブランチの作成も可能
* TeamCity
  * JetBrains 製 Jenkins
  * 無料枠あり
  * IntelliJ と連携するとビルド、テスト結果を受け取れる
    * テスト結果が IDE に通知されるので、素早く修正できる
* Upsource
  * コードレビューツール
  * 10 名まで永年無料
  * Github, Bitbuket, Gitlab とも連携可能
  * ブラウザ上で参照元をたどれる
  * ソースをローカルに pull してくる必要がない
  * IntelliJ と連携するとプルリクコメントも IDE 上で確認できる
* JRebel
  * クラスの動的リロードツール
* JHipster
  * 雛形生成ツール
  * Spring + Angular

## 50 min で最新技術学習の基礎を身につける
* 軸となる用語を一通り一気に学ぶ
  * パラシュート勉強法で
* マイクロサービス化の流れから Java EE を Eclipse Foundation に移管された
  * オラクルは、Java EE のマイクロサービス化に熱心でない
    * 関係者に取材して得た情報

## 感想
* クラウド、マイクロサービス化の話がよく出てきた印象
* 基調公演のデモでオラクルの人が Visual Studio Code 使っていてへぇーって感じだった

## スライド
* http://www.oracle.com/technetwork/jp/ondemand/online2018-javaday-4489556-ja.html
