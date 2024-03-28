import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeUserData(
      String userId, String username, String email) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'username': username,
        'email': email,
        // Add more fields as needed
      });
    } catch (e) {
      // Handle Firestore data storage errors
      print(e.toString());
      rethrow; // Re-throw the exception for higher-level error handling
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(userId).get();

      return documentSnapshot.exists
          ? documentSnapshot.data() as Map<String, dynamic>
          : null;
    } catch (e) {
      // Handle Firestore data retrieval errors
      print(e.toString());
      rethrow; // Re-throw the exception for higher-level error handling
    }
  }
}
