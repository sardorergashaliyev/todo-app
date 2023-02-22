import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/domain/model/todo_model.dart';
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';

class AuthController extends ChangeNotifier {
  Box? box;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String todoText = "";
  String phone = "";
  String? errorText = '';
  bool isLoading = false;
  bool isDone = false;
  bool isGoogleLoading = false;

  hiveInit() async {
    box = await Hive.openBox('country');
    notifyListeners();
  }

  login(String phone, String password, VoidCallback onSuccess) async {
    isLoading = true;
    errorText = null;
    notifyListeners();
    try {
      var res = await firestore
          .collection("users")
          .where("phone", isEqualTo: phone)
          .get();
      if (res.docs.first["password"] == password) {
        box?.put("password", res.docs.first.id);
        onSuccess();
        isLoading = false;
        notifyListeners();
      } else {
        errorText =
            "The password may be incorrect or the number may not be registered";
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      errorText =
          "The password may be incorrect or the number may not be registered";
      isLoading = false;
      notifyListeners();
    }
  }

  loginGoogle(VoidCallback onSuccess) async {
    isGoogleLoading = true;
    notifyListeners();
    GoogleSignIn googleSignIn = GoogleSignIn();

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userObj =
        await FirebaseAuth.instance.signInWithCredential(credential);
    // ignore: avoid_print
    print(userObj.additionalUserInfo?.isNewUser);
    if (userObj.additionalUserInfo?.isNewUser ?? true) {
      // sing in
      firestore
          .collection("users")
          .add(TodoModel(title: todoText, isDone: isDone).toJson())
          .then((value) async {
        box?.put("id", value.id);
        googleSignIn.signOut();
      });
    } else {
      // sing up
      var res = await firestore
          .collection("users")
          .where("email", isEqualTo: userObj.user?.email)
          .get();

      if (res.docs.isNotEmpty) {
        box?.put('id', res.docs.first.id);
      }
    }
    onSuccess();
    isGoogleLoading = false;
    notifyListeners();
  }
}
