import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  //Manage all auth changes here , globally for all screens of your application
  var authResultId = ''.obs;
  var authUserId = ''.obs;
  var userName = ''.obs;
}
