# sumup_sdk_wrapper

Flutter wrapper to use the latest SumUp SDK.

Connect to a SumUp terminal, login and accept card payments on Android.

## Prerequisites

1) Registered for a merchant account via SumUp's [country websites](https://sumup.de/flour) (or received a test account).
2) Received SumUp card terminal: Air, Air Lite, PIN+ terminal, Chip & Signature reader, or SumUp Air Register.
3) Requested an Affiliate (Access) Key and registered your application ID via [SumUp Dashboard](https://me.sumup.com/developers) for Developers.
4) Android minSdkVersion 23 or higher.

## Installing

Add sumup_sdk_wrapper to your pubspec.yaml:

```yaml
dependencies:
  sumup_sdk_wrapper:
```

Import sumup:

```dart
import 'package:sumup_sdk_wrapper/sumup_sdk_wrapper.dart';
```

## Getting Started

Init SumUp SDK:

```dart
SumupSdkWrapper.init(affiliateKey);
```

Login:

```dart
SumupSdkWrapper.login();
```

Or login with token:

```dart
SumupSdkWrapper.loginWithToken(token);
```

Choose your preferred terminal:

```dart
SumupSdkWrapper.openSettings();
```

Prepare terminal for checkout:

```dart
SumupSdkWrapper.prepareForCheckout();
```

Complete a transaction:

```dart
var payment = SumupPayment(
    title: 'Test payment',
    total: 1.2,
    currency: 'EUR',
    foreignTransactionID: '',
    saleItemsCount: 0,
    skipSuccessScreen: false,
    tip: .0,
);

var request = SumupPaymentRequest(payment);

SumupSdkWrapper.checkout(request);
```

## Available APIs

```dart
SumupSdkWrapper.init(affiliateKey);

SumupSdkWrapper.login();

SumupSdkWrapper.isLoggedIn;

SumupSdkWrapper.merchant;

SumupSdkWrapper.openSettings();

SumupSdkWrapper.prepareForCheckout();

SumupSdkWrapper.checkout(request);

SumupSdkWrapper.logout();

// iOS only
SumupSdkWrapper.isCheckoutInProgress;

```