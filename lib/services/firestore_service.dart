import 'package:cloud_firestore/cloud_firestore.dart';

// 1. MODEL CLASS (The Template for your data)
class Item {
  final String id;
  final String name;
  final int point;

  Item({
    required this.id,
    required this.name,
    required this.point
  });

  // Factory to convert Firestore Data -> Item Object
  factory Item.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw StateError('Data dokumen kosong!');
    }

    return Item(
        id: doc.id,
        name: data['name'] as String? ?? "No Name",
        point: (data['point'] as num?)?.toInt() ?? 0
    );
  }
}

// 2. SERVICE CLASS (The Connection)
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // READ (Stream of List<Item>)
  Stream<List<Item>> getItems() {
    return _db.collection('user_items') // Notice: He uses 'user_items'
        .snapshots()
        .map((snapshots) =>
        snapshots.docs.map((doc) => Item.fromFirestore(doc)).toList()
    );
  }

  // CREATE
  Future<DocumentReference<Map<String, dynamic>>> addItem(String name, int point) {
    return _db.collection('user_items').add({ // Must match the collection above
      'name': name,
      'point': point // He uses 'point', I used 'points'. We must use his.
    });
  }
}