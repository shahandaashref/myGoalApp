import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<DocumentReference> addDocument({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    try {
      final docRef = await _firestore.collection(collection).add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return docRef;
    } catch (e) {
      throw Exception('feild to add');
    }
  }

  static Future<void> setDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    try {
      await _firestore.collection(collection).doc(docId).set({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: merge));
    } catch (e) {
      throw Exception('');
    }
  }

  static Future<Map<String, dynamic>?> getDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      final doc = await _firestore.collection(collection).doc(docId).get();
      return doc.data();
    } catch (e) {
      throw Exception('feild to add');
    }
  }

  static Future<List<Map<String, dynamic>>> getAllDocument({
    required String collection,
  }) async {
    try {
      final snapshot = await _firestore.collection(collection).get();
      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    } catch (e) {
      throw Exception('feild to add $e');
    }
  }

  // static Future<List<Map<String, dynamic>>> queryDocument({
  //   required String collection,
  //   required String field,
  //   required dynamic value,
  //   String? operator = '==',
  // }) async {
  //   try {
  //     Query query = _firestore.collection(collection);
  //     switch (operator) {
  //       case '==':
  //         query = query.where(field, isEqualTo: value);
  //         break;
  //         case '<':
  //         query = query.where(field, isLessThan: value);
  //         break;
  //         case '<=':
  //         query = query.where(field, isLessThanOrEqualTo: value);
  //         break;
  //         case '>':
  //         query = query.where(field, isGreaterThan: value);
  //         break;
  //         case '>=':
  //         query = query.where(field, isGreaterThanOrEqualTo: value);
  //         break;
  //         case '!=':
  //         query = query.where(field, isNotEqualTo: value);
  //         break;
  //         case 'array-contains':
  //         query = query.where(field, arrayContains: value);
  //         break;
  //         case 'in':
  //         query = query.where(field, whereIn: value);
  //         break;
  //       default:
  //     }
  //   } catch (e) {
  //     throw Exception('feild to add $e');
  //   }
  // }
}
