import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_in_firebase/model/user_model.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> register(UserModel userModel) async {
    try {
      await _userReference.doc(userModel.id).set({
        "name": userModel.name,
        "email": userModel.email,
        "password": userModel.password,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getDataUserById(String userId) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(userId).get();
      return UserModel(
        id: userId,
        name: snapshot["name"],
        email: snapshot["email"],
        password: snapshot["password"],
      );
    } catch (e) {
      rethrow;
    }
  }
}
