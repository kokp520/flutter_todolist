// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_todolist/main.dart';

void main() {
  testWidgets('Todo app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // 驗證標題是否正確
    expect(find.text('像素風格待辦事項'), findsOneWidget);
    
    // 驗證新增按鈕是否存在
    expect(find.text('新增待辦'), findsOneWidget);
  });
}
