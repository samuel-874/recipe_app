import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/service/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>{

  final GlobalKey<FormState> _loginForKey = GlobalKey();
  String? username, password;
  bool _isLoading = false;

  @override
    Widget build(BuildContext context){
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Login"),
          ),
          body: SafeArea(
              child: _buildUI()),
        );
    }

  SizedBox _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              _title(),
            _loginForm(),

          ],
        ));
  }

  Widget _title(){
    return const Text(
      'Recip Book',
    style: TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.w300
    ),);
  }

  Widget _loginForm(){
      return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.90,
        height: MediaQuery.sizeOf(context).height * 0.30,
        child: Form(
          key: _loginForKey,
          child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: "emilys",
              validator: (value){
                  if(value == null || value.isEmpty){
                      return "Please Enter A Valid Username";
                  }
              },
              onSaved: (value){
                setState(() {
                  username = value;
                });
              },
              decoration: const InputDecoration(
                hintText: "Username",
              ),
            ),
            TextFormField(
              initialValue: 'emilyspass',
              obscureText: true,
              onSaved: (value){
                  setState(() {
                    password = value;
                  });
              },
              validator: (value){
                if(value == null || value.length < 5){
                  return "Please Enter A Valid Password";
                }
              },
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            _loginButton()
          ],
        ),)
      );
  }

  Widget _loginButton(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
      child: ElevatedButton(onPressed:() async {
        if(_loginForKey.currentState?.validate() ?? false){
            _loginForKey.currentState?.save();

            setState(() {
              _isLoading = true;
            });

            bool result = await AuthService().login(username!, password!);

            if(result){
              setState(() {
                _isLoading = false;
              });

              Navigator.pushReplacementNamed(context, "/home");

            }else{
              setState(() {
                _isLoading = false;
              });

              StatusAlert.show(
                context,
                duration: const Duration(seconds: 2),
                title: "Login Failed",
                subtitle: "Please try again",
                configuration: const IconConfiguration(
                  icon: Icons.error
                ), maxWidth: 260

              );
            }
        }
      } ,child: const Text('Login'),),
    );
  }
}