yesssss// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:ahilya_nagar_traffic_guard/main.dart';
import 'package:ahilya_nagar_traffic_guard/core/services/auth_service.dart';
import 'package:ahilya_nagar_traffic_guard/core/services/location_service.dart';
import 'package:ahilya_nagar_traffic_guard/core/services/notification_service.dart';

// Mock Firebase for testing
void setupFirebaseAuthMocks() {
  // This would normally contain Firebase mocking setup
}

void main() {
  setUpAll(() async {
    setupFirebaseAuthMocks();
  });

  testWidgets('App loads without crashing', (WidgetTester tester) async {
    // Create a test app with providers
    final testApp = MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider<LocationService>.value(value: LocationService()),
        ChangeNotifierProvider<NotificationService>.value(value: NotificationService()),
      ],
      child: MyApp(),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(testApp);

    // Verify that the app loads
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
