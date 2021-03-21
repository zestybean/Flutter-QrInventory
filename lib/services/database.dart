import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_inventory/models/inventory.dart';

class Database {
  final FirebaseFirestore firestore;

  Database(this.firestore);

  Stream<Inventory> streamInventory({String uid}){
    try{
      return firestore.collection("inventory").doc(uid).collection("inventoryItems").snapshots()
    } catch (e) {
      rethrow;
    }
  }
}
