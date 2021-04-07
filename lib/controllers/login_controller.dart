import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = _LoginController with _$LoginController;

abstract class _LoginController with Store {
  
  //Observable
  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool passwordVisible = false;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  //Action
  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void togglePasswordVisibility() => passwordVisible = !passwordVisible;

  @action
  Future<void> login() async {
    loading = true;

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    loggedIn = true;
  }

  @action
  void logout() {
    loggedIn = false;

    email = '';
    password = '';
  }  

  //Computed
  @computed
  bool get isEmailIsValid => email.length > 1;

  @computed
  bool get isPasswordIsValid => password.length > 1;

  @computed
  bool get isFormValid => isEmailIsValid && isPasswordIsValid;

  @computed
  Function get loginPressed =>
    (isEmailIsValid && isPasswordIsValid && !loading) ? login : null;
}