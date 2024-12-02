import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sumup_sdk_wrapper_platform_interface.dart';
import 'dart:async';

/// An implementation of [SumupSdkWrapperPlatform] that uses method channels.
class MethodChannelSumupSdkWrapper extends SumupSdkWrapperPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sumup_sdk_wrapper');

  @override
  Future<SumupPluginResponse> init(String affiliateKey) async {
    final init = await methodChannel.invokeMethod('initSDK', affiliateKey);
    return SumupPluginResponse.fromMap(init);
  }

  @override
  Future<SumupPluginResponse> login() async {
    final login = await methodChannel.invokeMethod('login');
    return SumupPluginResponse.fromMap(login);
  }

  @override
  Future<SumupPluginResponse> loginWithToken(String token) async {
    final loginWithToken = await methodChannel.invokeMethod('loginWithToken', token);
    return SumupPluginResponse.fromMap(loginWithToken);
  }

  @override
  Future<bool?> isLoggedIn() async {
    final isLoggedIn = await methodChannel.invokeMethod('isLoggedIn');
    return isLoggedIn;
  }

  @override
  Future<SumupPluginMerchantResponse> get merchant async {
    final merchant = await methodChannel.invokeMethod('getMerchant');
    final response = SumupPluginResponse.fromMap(merchant);
    return SumupPluginMerchantResponse.fromMap(response.message!);
  }

  @override
  Future<SumupPluginResponse> openSettings() async {
    final openSettings = await methodChannel.invokeMethod('openSettings');
    return SumupPluginResponse.fromMap(openSettings);
  }

  @override
  Future<SumupPluginResponse> prepareForCheckout() async {
    final prepareForCheckout = await methodChannel.invokeMethod('prepareForCheckout');
    return SumupPluginResponse.fromMap(prepareForCheckout);
  }

  @override
  Future<bool> get isTipOnCardReaderAvailable async {
    final isTipOnCardReaderAvailable = await methodChannel.invokeMethod('isTipOnCardReaderAvailable');
    return SumupPluginResponse.fromMap(isTipOnCardReaderAvailable).status;
  }

  @override
  Future<SumupPluginCheckoutResponse> checkout(SumupPaymentRequest paymentRequest) async {
    final request = paymentRequest.toMap();
    final checkout = await methodChannel.invokeMethod('checkout', request);
    final response = SumupPluginResponse.fromMap(checkout);
    return SumupPluginCheckoutResponse.fromMap(response.message!);
  }

  @override
  Future<SumupPluginResponse> logout() async {
    final logout = await methodChannel.invokeMethod('logout');
    return SumupPluginResponse.fromMap(logout);
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}