import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static Future<UserCredential?> loginUserEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
    }
    return null;

  }

   static Future<UserCredential?> signUpUserEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
    }
    return null;

  }

 static Future<UserCredential?> signOut() async {
    try {
      final userCredential = await _firebaseAuth.signOut(
        
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
    }
    return null;

  }

  //  static Future<UserCredential?>signInWithGoogle({
  //   required String email,
  //   required String password,
  // }) async {
  //   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  //   try {
  //     final userCredential = await _firebaseAuth.signInWithProvider(
  //     GoogleAuthProvider.credential()
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     print(e.code);
  //     print(e.message);
  //   }
  //   return null;

  // }
  
}
