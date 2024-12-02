import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sumup_sdk_wrapper/sumup_sdk_wrapper_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelSumupSdkWrapper platform = MethodChannelSumupSdkWrapper();
  const MethodChannel channel = MethodChannel('sumup_sdk_wrapper');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
