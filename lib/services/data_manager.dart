import 'package:get_it/get_it.dart';
import 'package:im/services/firebase_auth.dart';

class DataManager {
  final _authManager = GetIt.I<FirebaseAuthManager>();
}
