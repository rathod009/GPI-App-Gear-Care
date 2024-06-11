import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

//For Login Page
  Future<void> addUserLoginInfo(String email, String loginTimestamp) async {
    try {
      await _db.collection('user_logins').add({
        'email': email,
        'login_timestamp': loginTimestamp,
      });
    } catch (e) {
      print('Error adding user login info: $e');
    }
  }

  Stream<QuerySnapshot> getUserLogins() {
    return _db.collection('user_logins').snapshots();
  }
}
