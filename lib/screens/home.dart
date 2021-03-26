import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Local imports
import 'package:qr_inventory/services/auth.dart';
import 'package:qr_inventory/services/database.dart';
import 'package:qr_inventory/models/inventoryItem.dart';

class Home extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Home({Key key, this.auth, this.firestore}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _inventoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Inv Home"),
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Auth(auth: widget.auth).signOut();
              })
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text("Add Inventory Here: "),
          TextFormField(
            controller: _inventoryController,
          ),
          IconButton(
            onPressed: () {
              if (_inventoryController.text != "") {
                setState(() {
                  Database(firestore: widget.firestore).addInventoryItem(
                    uid: widget.auth.currentUser.uid,
                    props: {_inventoryController.text: "item"},
                  );
                  _inventoryController.clear();
                });
              }
            },
            icon: const Icon(Icons.add),
          ),
          const Text("Inventory List"),
          Expanded(
              child: StreamBuilder(
                  stream: Database(firestore: widget.firestore)
                      .streamInventory(uid: widget.auth.currentUser.uid),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<InventoryItem>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.data.isEmpty) {
                        return const Center(
                          child: Text("Empty"),
                        );
                      }

                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child:
                                          Text(snapshot.data[index].itemName))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("Loading..."),
                      );
                    }
                  }))
        ],
      ),
    );
  }
}
