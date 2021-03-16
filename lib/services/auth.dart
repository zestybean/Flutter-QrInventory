import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  //Firebase auth instance
  final FirebaseAuth auth;

  Auth({this.auth});

  //Anytime user state changes get user data
  Stream<User> get user => auth.authStateChanges();

  Future<String> createAccount({String email, String password}) async {
    //Create user with email and password trim both incase of spaces
    try {
      await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      //Good to go
      return "Success";
    } on FirebaseAuthException catch (e) {
      //Display error message from firebase
      return e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signIn({String email, String password}) async {
    //SignIn user with email and password trim both incase of spaces
    try {
      await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      //Good to go
      return "Success";
    } on FirebaseAuthException catch (e) {
      //Display error message from firebase
      return e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signOut() async {
    //SignOut user
    try {
      await auth.signOut();
      //Good to go
      return "Success";
    } on FirebaseAuthException catch (e) {
      //Display error message from firebase
      return e.message;
    } catch (e) {
      rethrow;
    }
  }
}
