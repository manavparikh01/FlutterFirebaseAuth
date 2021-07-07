import 'package:flutter/material.dart';

class AlternateAuthForm extends StatefulWidget {
  AlternateAuthForm(
    this.submitFN,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(String email, String password, String username,
      bool isLogin, BuildContext ctx) submitFN;

  @override
  _AlternateAuthFormState createState() => _AlternateAuthFormState();
}

class _AlternateAuthFormState extends State<AlternateAuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  RegExp emailRegex = new RegExp(
    r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$",
    caseSensitive: false,
    multiLine: false,
  );

  RegExp passwordRegex = new RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
      caseSensitive: false,
      multiLine: false);

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFN(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
      // print(_userEmail);
      // print(_userName);
      // print(_userPassword);
      // widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
      //     _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1,
      child: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value.isEmpty || !emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email address'),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Please enter at least 4 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Username'),
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || !passwordRegex.hasMatch(value)) {
                          return '''
Password must contain
1. Lower case letters 
2. Upper case letters
3. One special character 
4. One numerical character
                          ''';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      RaisedButton(
                        child: Text(_isLogin ? 'Login' : 'Signup'),
                        onPressed: _trySubmit,
                      ),
                    if (!widget.isLoading)
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'I already have an account'),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
