import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelo/user.dart';

class FirestoreService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(User user) {
    return usersCollection.add(user.toMap());
  }

  Future<void> updateUser(User user) {
    return usersCollection.doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String userId) {
    return usersCollection.doc(userId).delete();
  }

  Stream<List<User>> getUsers() {
    return usersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => User.fromDocument(doc)).toList();
    });
  }
}
