import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_inventory/models/inventoryItem.dart';

class Database {
  final FirebaseFirestore firestore;

  Database({this.firestore});

  Stream<List<InventoryItem>> streamInventory({String uid}) {
    try {
      return firestore
          .collection("inventory")
          .doc(uid)
          .collection("inventoryItems")
          .snapshots()
          .map((query) {
        List<InventoryItem> retVal;
        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(
            InventoryItem.fromDocumentSnapshots(documentSnapshot: doc),
          );

          print(retVal.length);
        }

        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addInventoryItem(
      {String uid, String itemName, Map<String, String> props}) async {
    try {
      firestore
          .collection("inventory")
          .doc(uid)
          .collection("inventoryItems")
          .add({
        "name": itemName,
        "properties": props,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateInventoryItem(
      {String uid, String itemId, Map<String, String> props}) async {
    try {
      firestore
          .collection("inventory")
          .doc(uid)
          .collection("inventoryItems")
          .doc(itemId)
          .update({
        "properties": props,
      });
    } catch (e) {
      rethrow;
    }
  }
}
