import 'sumup_sdk_wrapper_platform_interface.dart';
import 'dart:async';

class SumupSdkWrapper {
  SumupSdkWrapper._();

  static bool _isInitialized = false;

  static void _throwIfNotInitialized() {
    if (!_isInitialized) {
      throw Exception('SumUp SDK is not initialized. You should call Sumup.init(affiliateKey)');
    }
  }

  static Future<void> _throwIfNotLoggedIn() async {
    final isLogged = await isLoggedIn();
    if (isLogged == null || !isLogged) {
      throw Exception('Not logged in. You must login before.');
    }
  }

  /// Initializes SumUp SDK with your [affiliateKey].
  ///
  /// Must be called only once before anything else. Calling this again has no effect since
  /// the SDK has already been initialized.
  static Future<SumupPluginResponse> init(String affiliateKey) async {
    if (_isInitialized) {
      return SumupPluginResponse.fromMap({
        'methodName': 'initSDK',
        'status': true,
        'message': {'initialized': true}
      });
    }
    final response = await SumupSdkWrapperPlatform.instance.init(affiliateKey);
    if(response.status) {
      _isInitialized = true;
    }
    return response;
  }

  /// Shows SumUp login dialog.
  ///
  /// Should be called after [init].
  static Future<SumupPluginResponse> login() {
    return SumupSdkWrapperPlatform.instance.login();
  }

  /// Uses Transparent authentication to login to SumUp SDK with supplied token.
  ///
  /// Should be called after [init].
  static Future<SumupPluginResponse> loginWithToken(String token) {
    return SumupSdkWrapperPlatform.instance.loginWithToken(token);
  }

  /// Returns whether merchant is already logged in.
  static Future<bool?> isLoggedIn() {
    return SumupSdkWrapperPlatform.instance.isLoggedIn();
  }

  /// Returns the current merchant.
  static Future<SumupPluginMerchantResponse> get merchant async {
    _throwIfNotInitialized();
    await _throwIfNotLoggedIn();
    return SumupSdkWrapperPlatform.instance.merchant;
  }

  /// Opens SumUp dialog to connect to a card terminal.
  ///
  /// Login required.
  static Future<SumupPluginResponse> openSettings() async {
    _throwIfNotInitialized();
    await _throwIfNotLoggedIn();
    return SumupSdkWrapperPlatform.instance.openSettings();
  }

  /// Wakes up card terminal before real checkout to speed up bluetooth pairing process.
  ///
  /// Don't call this method during checkout because it can lead to checkout failure.
  /// Login required.
  @Deprecated('Use prepareForCheckout() instead')
  static Future<SumupPluginResponse> wakeUpTerminal() {
    return prepareForCheckout();
  }

  /// Calling prepareForCheckout() before instancing a checkout will
  /// speed up the checkout time.
  ///
  /// Don't call this method during checkout because it can lead to checkout failure.
  /// Login required.
  static Future<SumupPluginResponse> prepareForCheckout() async {
    _throwIfNotInitialized();
    await _throwIfNotLoggedIn();
    return SumupSdkWrapperPlatform.instance.prepareForCheckout();
  }

  /// Checks if Tip on Card Reader (TCR) feature is available.
  ///
  /// Login required.
  static Future<bool> get isTipOnCardReaderAvailable async {
    _throwIfNotInitialized();
    await _throwIfNotLoggedIn();
    return SumupSdkWrapperPlatform.instance.isTipOnCardReaderAvailable;
  }

  /// Starts a checkout process with [paymentRequest].
  ///
  /// Login required.
  static Future<SumupPluginCheckoutResponse> checkout(SumupPaymentRequest paymentRequest) async {
    _throwIfNotInitialized();
    await _throwIfNotLoggedIn();

    if (paymentRequest.payment.tipOnCardReader && paymentRequest.payment.tip > 0) {
      throw Exception('Cannot perform checkout with [tip] greater than 0 and [tipOnCardReader] true');
    }
    return SumupSdkWrapperPlatform.instance.checkout(paymentRequest);
  }

  /// Performs logout.
  static Future<SumupPluginResponse> logout() {
    return SumupSdkWrapperPlatform.instance.logout();
  }

  static Future<String?> getPlatformVersion() {
    return SumupSdkWrapperPlatform.instance.getPlatformVersion();
  }
}
