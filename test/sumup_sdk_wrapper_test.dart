import 'package:flutter_test/flutter_test.dart';
import 'package:sumup_sdk_wrapper/sumup_sdk_wrapper.dart';
import 'package:sumup_sdk_wrapper/sumup_sdk_wrapper_platform_interface.dart';
import 'package:sumup_sdk_wrapper/sumup_sdk_wrapper_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSumupSdkWrapperPlatform
    with MockPlatformInterfaceMixin
    implements SumupSdkWrapperPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SumupSdkWrapperPlatform initialPlatform = SumupSdkWrapperPlatform.instance;

  test('$MethodChannelSumupSdkWrapper is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSumupSdkWrapper>());
  });

  test('getPlatformVersion', () async {
    SumupSdkWrapper sumupSdkWrapperPlugin = SumupSdkWrapper();
    MockSumupSdkWrapperPlatform fakePlatform = MockSumupSdkWrapperPlatform();
    SumupSdkWrapperPlatform.instance = fakePlatform;

    expect(await sumupSdkWrapperPlugin.getPlatformVersion(), '42');
  });
}
