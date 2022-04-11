import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_firebase/model/user_model.dart';
import 'package:sign_in_firebase/service/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          name: name,
          email: email,
          password: password);

      await UserService().register(userModel);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserService().getDataUserById(userCredential.user!.uid);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
