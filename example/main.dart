import 'package:pantry/pantry.dart';

void main(List<String> args) async {
  final pantry = Pantry(args.isEmpty ? "" : args.first);

  try {
    // Get pantry details
    final pantryDetails = await pantry.getPantry();
    print("Pantry Details: $pantryDetails");

    // Update pantry
    final updatedPantry = await pantry.updatePantry(
        "My Pantry", "This is my pantry description!");
    print("Updated Pantry: $updatedPantry");

    // Create or replace a basket
    final basketName = "My Basket";
    final newBasketResult = await pantry.newBasket(basketName, {
      "derp": "flerp123",
      "testPayload": true,
      "keysLength": 3,
    });
    print(newBasketResult);

    // Update basket content
    final updatedBasketContent =
        await pantry.updateBasket(basketName, {"new_key": "new_value"});
    print("Updated Basket Content: $updatedBasketContent");

    // Get basket content
    final basketContent = await pantry.getBasket(basketName);
    print("Basket Content: $basketContent");

    // Delete basket
    final deleteBasketResult = await pantry.deleteBasket(basketName);
    print(deleteBasketResult);
  } on PantryException catch (e) {
    print("Pantry Exception: $e");
  } catch (e) {
    print("Error: $e");
  }
}
