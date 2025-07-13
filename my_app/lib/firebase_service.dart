import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static CollectionReference get itemsCollection => _firestore.collection('items');

  static Future<void> addItem(LostFoundItem item) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      await itemsCollection.add({
        'imageUrl': item.image,
        'title': item.title,
        'description': item.desc,
        'tag': item.tag,
        'contactInfo': item.contact,
        'authorId': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add item: $e');
    }
  }

  static Stream<List<LostFoundItem>> getItemsStream() {
    return itemsCollection
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return LostFoundItem(
          image: data['imageUrl'] ?? '',
          title: data['title'] ?? '',
          desc: data['description'] ?? '',
          tag: data['tag'] ?? '',
          contact: data['contactInfo'] ?? '',
          authorId: data['authorId'] ?? '',
        );
      }).toList();
    });
  }

  static Future<void> deleteItem(String itemId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final doc = await itemsCollection.doc(itemId).get();
      if (!doc.exists) throw Exception('Item not found');

      final data = doc.data() as Map<String, dynamic>;
      if (data['authorId'] != user.uid) {
        throw Exception('You can only delete your own items');
      }

      await itemsCollection.doc(itemId).delete();
    } catch (e) {
      throw Exception('Failed to delete item: $e');
    }
  }


} 