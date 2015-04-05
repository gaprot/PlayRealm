# Play Realm

　ギャップロ記事のサンプルコードです。下記の設定を行った上でビルド＆実行するようにしてくださ。

## CocoaPods

　ライブラリのインポートに [CocoaPods](http://cocoapods.org) を使用しますので、ターミナルで `pod install` を行った後、`PlayRealm.xcworkspace` を開いてください。

## API キーの設定

　Google APIs を使用していますので、取得した API キーを以下の部分に設定してください。

```PlaceServiceProvider.m
#define GOOGLE_API_KEY @"YOUR-API-KEY"
```
