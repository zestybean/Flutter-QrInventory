import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_inventory/models/inventoryItem.dart';

class Inventory {
  String inventoryId;
  List<InventoryItem> inventoryItems;

  Inventory({
    this.inventoryId,
    this.inventoryItems,
  });

  Inventory.fromDocumentSnapshots({DocumentSnapshot documentSnapshot}) {
    inventoryId = documentSnapshot.id;
    inventoryItems =
        documentSnapshot.data()['inventoryItems'] as List<InventoryItem>;
  }
}
