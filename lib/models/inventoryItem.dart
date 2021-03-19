import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryItem {
  String itemId;
  String itemName;
  Map<String, String> properties;

  InventoryItem({
    this.itemId,
    this.itemName,
    this.properties,
  });

  InventoryItem.fromDocumentSnapshots({DocumentSnapshot documentSnapshot}) {
    itemId = documentSnapshot.id;
    itemName = documentSnapshot.data()['name'] as String;
    properties = documentSnapshot.data()['properties'] as Map<String, String>;
  }
}
