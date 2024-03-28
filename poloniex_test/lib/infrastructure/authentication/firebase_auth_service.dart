// lib/infrastructure/authentication/firebase_auth_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }

  Future<User?> registerWithEmailAndPassword(
      String username, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user != null) {
        await _storeUserData(user.uid, username, password);
        // await user.updateDisplayName(name);
        return user;
      }

      return null;
    } catch (error) {
      print("Error during registration: $error");
      return null;
    }
  }

  Future<void> _storeUserData(
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
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      return user;
    } catch (error) {
      print("Error during login: $error");
      return null;
    }
  }

  Future<User?> signInWithUsernameAndPassword(
      String username, String password) async {
    try {
      // Get the user document with the provided username
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String email = querySnapshot.docs.first.get('email');

        // Sign in with the retrieved email and password
        return await _auth
            .signInWithEmailAndPassword(
              email: email,
              password: password,
            )
            .then((value) => value.user);
      } else {
        // Username not found
        return null;
      }
    } catch (e) {
      // Handle login errors
      print(e.toString());
      return null;
    }
  }
  // Add other authentication methods as needed
}
