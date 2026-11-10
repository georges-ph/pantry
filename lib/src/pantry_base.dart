import 'dart:convert';

import 'package:http/http.dart' as http;

import 'exceptions.dart';
import 'models/pantry_model.dart';

class Pantry {
  /// Pantry ID
  final String id;

  Pantry(this.id);

  /// Gets a pantry details such as name, description and baskets.
  ///
  /// Throws a [PantryException] when failed.
  Future<PantryModel> getPantry() async {
    try {
      final response = await http.get(
        Uri.https("getpantry.cloud", "apiv1/pantry/$id"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 200) {
        throw PantryException(response.body);
      }

      return PantryModel.fromJson(response.body);
    } catch (e) {
      if (e is PantryException) rethrow;
      throw PantryException("Could not get pantry", e.toString());
    }
  }

  /// Updates a pantry details.
  ///
  /// Use [name] to change the pantry name and [description] to change the pantry description.
  ///
  /// Throws a [PantryException] when failed.
  Future<PantryModel> updatePantry([String? name, String? description]) async {
    try {
      final response = await http.put(
        Uri.https("getpantry.cloud", "apiv1/pantry/$id"),
        headers: {"Content-Type": "application/json"},
        body: PantryModel(name: name, description: description).toJson(),
      );

      if (response.statusCode != 200) {
        throw PantryException(response.body);
      }

      return PantryModel.fromJson(response.body);
    } catch (e) {
      if (e is PantryException) rethrow;
      throw PantryException("Could not update pantry", e.toString());
    }
  }

  /// Creates a new basket or replaces an existing one.
  ///
  /// The basket will be created or replaced based on [basketName] using the [basketContent] map.
  ///
  /// Throws a [PantryException] when failed.
  Future<String> newBasket(
      String basketName, Map<String, dynamic> basketContent) async {
    try {
      final response = await http.post(
        Uri.https("getpantry.cloud", "apiv1/pantry/$id/basket/$basketName"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(basketContent),
      );

      if (response.statusCode != 200) {
        throw PantryException(response.body);
      }

      return "Pantry was updated with basket: $basketName!";
    } catch (e) {
      if (e is PantryException) rethrow;
      throw PantryException("Could not create/replace basket", e.toString());
    }
  }

  /// Updates the existing contents of a basket.
  ///
  /// The basket will be updated based on [basketName] using the [basketContent] map.
  /// May overwrite the values of existing keys or append the values to nested objects or arrays.
  ///
  /// Returns the JSON decoded basket content as [Map].
  ///
  /// Throws a [PantryException] when failed.
  Future<Map<String, dynamic>> updateBasket(
      String basketName, Map<String, dynamic> basketContent) async {
    try {
      final response = await http.put(
        Uri.https("getpantry.cloud", "apiv1/pantry/$id/basket/$basketName"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(basketContent),
      );

      if (response.statusCode != 200) {
        throw PantryException(response.body);
      }

      return jsonDecode(response.body);
    } catch (e) {
      if (e is PantryException) rethrow;
      throw PantryException("Could not update basket", e.toString());
    }
  }

  /// Gets the content of a basket by its name.
  ///
  /// Returns the JSON decoded basket content as [Map].
  ///
  /// Throws a [PantryException] when failed.
  Future<Map<String, dynamic>> getBasket(String basketName) async {
    try {
      final response = await http.get(
        Uri.https("getpantry.cloud", "apiv1/pantry/$id/basket/$basketName"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 200) {
        throw PantryException(response.body);
      }

      return jsonDecode(response.body);
    } catch (e) {
      if (e is PantryException) rethrow;
      throw PantryException("Could not get basket", e.toString());
    }
  }

  /// Deletes the entire basket by its name.
  ///
  /// This action is irreversible.
  ///
  /// Throws a [PantryException] when failed.
  Future<String> deleteBasket(String basketName) async {
    try {
      final response = await http.delete(
        Uri.https("getpantry.cloud", "apiv1/pantry/$id/basket/$basketName"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 200) {
        throw PantryException(response.body);
      }

      return "$basketName was removed from your Pantry!";
    } catch (e) {
      if (e is PantryException) rethrow;
      throw PantryException("Could not delete basket", e.toString());
    }
  }
}
