import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sumup_sdk_wrapper_method_channel.dart';
import 'dart:async';

import 'models/sumup_payment.dart';
import 'models/sumup_payment_request.dart';
import 'models/sumup_plugin_checkout_response.dart';
import 'models/sumup_plugin_merchant_response.dart';
import 'models/sumup_plugin_response.dart';

export 'models/sumup_payment.dart';
export 'models/sumup_payment_request.dart';
export 'models/sumup_plugin_checkout_response.dart';
export 'models/sumup_plugin_merchant_response.dart';
export 'models/sumup_plugin_response.dart';


abstract class SumupSdkWrapperPlatform extends PlatformInterface {
  /// Constructs a SumupSdkWrapperPlatform.
  SumupSdkWrapperPlatform() : super(token: _token);

  static final Object _token = Object();

  static SumupSdkWrapperPlatform _instance = MethodChannelSumupSdkWrapper();

  /// The default instance of [SumupSdkWrapperPlatform] to use.
  ///
  /// Defaults to [MethodChannelSumupSdkWrapper].
  static SumupSdkWrapperPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SumupSdkWrapperPlatform] when
  /// they register themselves.
  static set instance(SumupSdkWrapperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<SumupPluginResponse> init(String affiliateKey) {
    throw UnimplementedError('init() has not been implemented');
  }

  Future<SumupPluginResponse> login() {
    throw UnimplementedError('login() has not been implemented');
  }

  Future<SumupPluginResponse> loginWithToken(String token) {
    throw UnimplementedError('loginWithToken() has not been implemented');
  }

  Future<bool?> isLoggedIn() {
    throw UnimplementedError('isLoggedIn() has not been implemented');
  }

  Future<SumupPluginMerchantResponse> get merchant {
    throw UnimplementedError('get merchant has not been implemented');
  }

  Future<SumupPluginResponse> openSettings() {
    throw UnimplementedError('openSettings() has not been implemented');
  }

  Future<SumupPluginResponse> prepareForCheckout() {
    throw UnimplementedError('prepareForCheckout() has not been implemented');
  }
  
  Future<bool> get isTipOnCardReaderAvailable {
    throw UnimplementedError('get isTipOnCardReaderAvailable has not been implemented');
  }

  Future<SumupPluginCheckoutResponse> checkout(SumupPaymentRequest paymentRequest) {
    throw UnimplementedError('checkout() has not been implemented');
  }

  Future<bool?> get isCheckoutInProgress {
    throw UnimplementedError('isCheckoutInProgress has not been implemented');
  }

  Future<SumupPluginResponse> logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

