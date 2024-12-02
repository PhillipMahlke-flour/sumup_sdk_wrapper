// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing


import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/foundation.dart';

import 'package:sumup_sdk_wrapper/sumup_sdk_wrapper.dart';

import 'package:sumup_sdk_wrapper/models/sumup_payment.dart';
import 'package:sumup_sdk_wrapper/models/sumup_payment_request.dart';
import 'package:sumup_sdk_wrapper/models/sumup_plugin_checkout_response.dart';
import 'package:sumup_sdk_wrapper/models/sumup_plugin_merchant_response.dart';
import 'package:sumup_sdk_wrapper/models/sumup_plugin_response.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final SumupSdkWrapper plugin = SumupSdkWrapper();

  testWidgets('init test', (WidgetTester tester) async {
    final FlutterExceptionHandler? originalOnError = FlutterError.onError;

    final String affiliateKey = "";
    final SumupPluginResponse response = await plugin.init(affiliateKey);

    await tester.pumpAndSettle();
    FlutterError.onError = originalOnError;
    expect(response.status, true);
  });

  testWidgets('login test', (WidgetTester tester) async {
    final FlutterExceptionHandler? originalOnError = FlutterError.onError;

    await plugin.login();
    final bool? response = await plugin.isLoggedIn();
    

    await tester.pumpAndSettle();
    FlutterError.onError = originalOnError;
    expect(response!, true);
  });  

  testWidgets('merchant test', (WidgetTester tester) async {
    final FlutterExceptionHandler? originalOnError = FlutterError.onError;

    final SumupPluginMerchantResponse response = await plugin.merchant;

    await tester.pumpAndSettle();
    FlutterError.onError = originalOnError;
    expect(response.merchantCode != "", true);
  });

  testWidgets('openSettings test', (WidgetTester tester) async {
    final FlutterExceptionHandler? originalOnError = FlutterError.onError;

    await plugin.openSettings();
    final SumupPluginResponse response = await plugin.prepareForCheckout();

    await tester.pumpAndSettle();
    FlutterError.onError = originalOnError;
    expect(response.status, true);
  });
  
  testWidgets('checkout test', (WidgetTester tester) async {
    final FlutterExceptionHandler? originalOnError = FlutterError.onError;

    SumupPayment payment = SumupPayment(
      title: "integration test",
      total: 13.37,
      currency: "EUR",
      foreignTransactionId: '',
      saleItemsCount: 1,
      skipSuccessScreen: false,
      tip: 0.0,
    );
    final SumupPaymentRequest paymentRequest = SumupPaymentRequest(payment);
    final SumupPluginCheckoutResponse response = await plugin.checkout(paymentRequest);

    await tester.pumpAndSettle();
    FlutterError.onError = originalOnError;
    expect(response.success, true);
  });

  testWidgets('logout test', (WidgetTester tester) async {
    final FlutterExceptionHandler? originalOnError = FlutterError.onError;
    final SumupPluginResponse response = await plugin.logout();

    await tester.pumpAndSettle();
    FlutterError.onError = originalOnError;
    expect(response.status, true);
  });
}
