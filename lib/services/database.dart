import 'package:appli/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({
    this.uid,
  });

  // collection reference
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future<void> updateUserData(String fullName, String email, String password,
      String avatar, int score) async {
    return await usersCollection.document(uid).setData({
      'FullName': fullName,
      'Email': email,
      'Password': password,
      'Avatar': avatar,
      'Score': score,
      // niveau, domaine, question
    });
  }

  Future<void> updateUserProfilePicture(String avatarr) async {
    return await usersCollection.document(uid).setData({
      'Avatar': avatarr,
      // niveau, domaine, question
    });
  }

  // user data from snapshots
  User _userFromSnapshot(DocumentSnapshot snapshot) {
    return User(
        uid: uid,
        fullname: snapshot.data['FullName'],
        email: snapshot.data['Email'],
        password: snapshot.data['Password'],
        avatar: snapshot.data['Avatar'],
        score: snapshot.data['Score']);
  }

  // get user doc stream
  Stream<User> get userData {
    return usersCollection.document(uid).snapshots().map(_userFromSnapshot);
  }
}
    // await DatabaseService(uid: newUser.uid)
    //                               .updateUserData(usernameRegister, email,
    //                                   password, avatar, score);