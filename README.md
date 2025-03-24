# 📝 TodoList App

嗨！這是一個使用Flutter打造的待辦事項清單App。主題符合我喜歡的pixel風格，功能完整的待辦事項管理工具。

## ✨ Features

這個App能幫你：
- 輕鬆管理日常待辦事項（新增、編輯、刪除都超直覺！）
- 一鍵完成待辦事項
- 用漂亮的介面記錄生活大小事
- 所有資料都安全地存在你的手機裡
- 支援深色模式，保護你的眼睛 🌙

## 🔧 Setting

開發這個App需要：
- Flutter SDK（3.0.0+）
- Dart SDK（2.17.0+）
- iOS 11.0+ / Android 5.0+
- Xcode (for iOS)
- Apple Developer Account (for TestFlight)
- Firebase <建立.env.local>

## 🚀 Go

1. Check if you have Flutter installed:
```bash
flutter doctor
```

2. Clone the project:
```bash
git clone https://github.com/yourusername/flutter_todolist.git
cd flutter_todolist
```

3. Install dependencies:
```bash
flutter pub get
```

4. 建立.env.local：
```bash
cp .env.example .env.local
```

6. Start App：
```bash
flutter run
```

7. 其他：
看Makefile

## 📦 Build & Deploy

### iOS TestFlight 發布流程

1. 更新版本號（在 pubspec.yaml）：
```yaml
version: 1.0.0+1  # 格式是 version_name+build_number
```

2. 產生發布版本：
```bash
# 清理之前的建置
flutter clean

# 取得相依套件
flutter pub get

# 建置 iOS 發布版本
flutter build ios --release

# 或使用這個指令建置並自動遞增版本號
flutter build ios --release --build-name=1.0.0 --build-number=1
```

3. 打開 Xcode 專案：
```bash
cd ios
open Runner.xcworkspace
```

4. 在 Xcode 中：
- 確認 Signing & Capabilities 設定正確
- 選擇 Any iOS Device (arm64)
- Product > Archive
- 上傳到 App Store Connect

5. 在 App Store Connect：
- 前往 TestFlight 分頁
- 等待處理完成
- 新增測試人員和群組
- 開始測試

### 自動化腳本（選擇性）

在 Makefile 加入：
```makefile
build-ios-testflight:
    flutter clean
    flutter pub get
    flutter build ios --release
    cd ios && xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Release archive -archivePath build/Runner.xcarchive
    cd ios && xcodebuild -exportArchive -archivePath build/Runner.xcarchive -exportOptionsPlist exportOptions.plist -exportPath build/Runner.ipa
```

## 📁 Project Structure

```
lib/
  ├── models/      # 資料的格式定義
  ├── screens/     # 各個畫面
  ├── widgets/     # 可重複使用的UI元件
  ├── services/    # 處理資料的邏輯
  └── main.dart    # App的進入點
```

## 📚 Learn More?

- [寫出你的第一個Flutter App](https://docs.flutter.dev/get-started/codelab)
- [超實用的Flutter範例](https://docs.flutter.dev/cookbook)
- [完整的Flutter文件](https://docs.flutter.dev/)

## 🤝 Contribute

有想法或建議嗎？非常歡迎你的參與！

1. Fork this
2. create a new branch: `git checkout -b feature/your-idea`
3. commit your changes: `git commit -m 'added a great new feature'`
4. push to your fork: `git push origin feature/your-idea`
5. send a PR to discuss

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---
Made with Flutter
