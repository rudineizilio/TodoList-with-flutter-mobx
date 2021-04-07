import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/controllers/login_controller.dart';
import 'package:todomobx/widgets/custom_icon_button.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

import 'list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController _loginController;

  ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    _loginController = Provider.of<LoginController>(context);

    // autorun((_) {
    //   if (_loginController.loggedIn) {
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (_) => ListScreen())
    //     );
    //   }
    // });
    reaction(
      (_) => _loginController.loggedIn,
      (loggedIn) {
        if (_loginController.loggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => ListScreen())
          );
        }
      }
    );

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    disposer();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Observer(builder: (_) {
                      return CustomTextField(
                        hint: 'E-mail',
                        prefix: Icon(Icons.account_circle),
                        textInputType: TextInputType.emailAddress,
                        onChanged: _loginController.setEmail,
                        enabled: !_loginController.loading,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(builder: (_) {
                      return CustomTextField(
                        hint: 'Senha',
                        prefix: Icon(Icons.lock),
                        obscure: !_loginController.passwordVisible,
                        onChanged: _loginController.setPassword,
                        enabled: !_loginController.loading,
                        suffix: CustomIconButton(
                          radius: 32,
                          iconData: !_loginController.passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onTap: () {
                            _loginController.togglePasswordVisibility();
                          },
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: Observer(builder: (_) {
                        return RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: _loginController.loading
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : Text('Login'),
                          color: Theme.of(context).primaryColor,
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          textColor: Colors.white,
                          onPressed: _loginController.loginPressed
                        );
                      }),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
