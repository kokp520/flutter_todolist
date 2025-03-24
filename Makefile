# Flutter iOS 打包相關指令
.PHONY: help clean setup build-ios pod-install pod-update check reset-ios archive web web-build web-serve web-debug

# 顯示所有可用的指令
help:
	@echo "可用的指令："
	@echo "make clean         - 清理專案"
	@echo "make setup        - 初始化專案設定"
	@echo "make build-ios    - 建立 iOS 發布版本"
	@echo "make pod-install  - 安裝 iOS 依賴"
	@echo "make pod-update   - 更新 iOS 依賴"
	@echo "make check        - 檢查環境設定"
	@echo "make reset-ios    - 重置 iOS 相關設定"
	@echo "make archive      - 完整打包流程"
	@echo "make web          - 啟動網頁版本預覽"
	@echo "make web-build    - 建立網頁版本"
	@echo "make web-serve    - 在本地伺服器上測試網頁版本"
	@echo "make web-debug    - 使用除錯模式啟動網頁版本"

# 清理專案
clean:
	flutter clean
	rm -rf ios/Pods
	rm -rf ios/.symlinks
	rm -rf ios/Flutter/Flutter.framework
	rm -rf ios/Flutter/Flutter.podspec
	rm -rf ~/Library/Developer/Xcode/DerivedData

# 初始化設定
setup: clean
	flutter pub get

# 建立 iOS 發布版本
build-ios:
	flutter build ios --release

# 安裝 iOS 依賴
pod-install:
	cd ios && pod install

# 更新 iOS 依賴
pod-update:
	cd ios && pod update

# 檢查環境設定
check:
	flutter doctor
	flutter devices
	security find-identity -v -p codesigning

# 重置 iOS 相關設定
reset-ios:
	xcrun simctl erase all
	rm -rf ~/Library/Caches/CocoaPods
	pod cache clean --all
	cd ios && pod deintegrate
	cd ios && pod setup
	make pod-install

# 完整打包流程
archive: clean setup pod-install build-ios
	@echo "iOS 打包完成"
	@echo "請使用 Xcode 開啟 ios/Runner.xcworkspace 進行後續封存操作"

# 錯誤處理提示
error:
	@echo "如果遇到問題，請嘗試以下步驟："
	@echo "1. 執行 make clean"
	@echo "2. 執行 make setup"
	@echo "3. 執行 make pod-install"
	@echo "4. 重新開啟 Xcode"
	@echo "5. 檢查證書和描述檔"

# 啟動網頁版本預覽
web:
	flutter run -d chrome --web-port 54135 --verbose --web-browser-flag="--disable-application-cache"

# 建立網頁版本
web-build:
	flutter clean
	flutter pub get
	flutter build web --verbose
	@echo "網頁版本建立完成，檔案位於 build/web 目錄"

# 在本地伺服器上測試
web-serve: web-build
	@echo "正在啟動本地伺服器..."
	cd build/web && python3 -m http.server 54135
	@echo "請在瀏覽器中開啟 http://localhost:54135 查看網頁版本"

# 網頁版本除錯模式
web-debug:
	flutter clean
	flutter pub get
	flutter config --enable-web
	flutter create . --platforms web
	flutter run -d chrome --dart-define=FLUTTER_WEB_USE_SKIA=true --web-port 54135 --verbose

# 啟動網頁版本預覽
web:
	flutter run -d chrome --web-port 54135 --verbose --web-browser-flag="--disable-application-cache"

# 建立網頁版本
web-build:
	flutter clean
	flutter pub get
	flutter build web --verbose
	@echo "網頁版本建立完成，檔案位於 build/web 目錄"

# 在本地伺服器上測試
web-serve: web-build
	@echo "正在啟動本地伺服器..."
	cd build/web && python3 -m http.server 54135
	@echo "請在瀏覽器中開啟 http://localhost:54135 查看網頁版本" 