[![CI](https://github.com/georges-ph/pantry/actions/workflows/ci.yml/badge.svg)](https://github.com/georges-ph/pantry/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/georges-ph/pantry)](https://github.com/georges-ph/pantry/releases)
[![License: BSD-3-Clause](https://img.shields.io/badge/license-BSD--3--Clause-blue.svg)](LICENSE)

A small Dart wrapper for the [Pantry](https://getpantry.cloud/) JSON storage API. Store, read, update and delete JSON "baskets" in a free cloud pantry, from any Dart or Flutter app.

## Getting started

Add the package:
```
dart pub add pantry
```

Get a free pantry ID from [getpantry.cloud](https://getpantry.cloud), then create a `Pantry` with it:
```dart
import 'package:pantry/pantry.dart';

final pantry = Pantry("xxxx-xxxx-xxxx-xxxx-xxxx-xxxx");
```

## Usage

### Pantry details
```dart
final details = await pantry.getPantry();
print(details.baskets);

await pantry.updatePantry("My Pantry", "A new description");
```

### Create or replace a basket
```dart
final newBasketResult = await pantry.newBasket("My Basket", {
  "derp": "flerp123",
  "testPayload": true,
  "keysLength": 3,
});
print(newBasketResult);
```

### Retrieve basket contents
```dart
final basketContent = await pantry.getBasket("My Basket");
print("Basket Content: $basketContent");
```

### Update basket contents
Merges the new keys into the existing basket:
```dart
final updatedBasketContent = await pantry.updateBasket("My Basket", {"new_key": "new_value"});
print("Updated Basket Content: $updatedBasketContent");
```

### Delete a basket
```dart
final deleteBasketResult = await pantry.deleteBasket("My Basket");
print(deleteBasketResult);
```

### Errors
Every method throws a `PantryException` when the request fails, with Pantry's own message when it sends one:
```dart
try {
  await pantry.getBasket("Missing Basket");
} on PantryException catch (e) {
  print(e.message);
}
```

Pantry is a free service and rate-limits requests made in quick succession, so space out repeated calls.

A full example is in [`example/main.dart`](example/main.dart):
```
dart run example/main.dart <your-pantry-id>
```

## Status

Stable and maintained. Published on [pub.dev](https://pub.dev/packages/pantry).
