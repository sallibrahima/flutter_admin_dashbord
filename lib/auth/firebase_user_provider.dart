import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AdmindashboardFirebaseUser {
  AdmindashboardFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

AdmindashboardFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AdmindashboardFirebaseUser> admindashboardFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<AdmindashboardFirebaseUser>(
      (user) {
        currentUser = AdmindashboardFirebaseUser(user);
        return currentUser!;
      },
    );
