
import 'package:bottom_navigation_bar/views/login/widget/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../blocs/login_bloc/login_bloc.dart';
import 'widget/widgets.dart';
class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;
  final emailFocusNode =FocusNode();
  final passwordFocusNode=FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginBloc = LoginBloc();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => loginBloc,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      child: Icon(
                        Icons.account_circle,size: 80,color: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    EmailInputWidget(emailFocusNode: emailFocusNode),
                    SizedBox(
                      height: 18,
                    ),
                    PasswordInputWidget(passwordFocusNode: passwordFocusNode),
                    SizedBox(
                      height: 18,
                    ),
                    LoginButton(formKey: _formKey,),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have account?'),
                        TextButton(onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>signup()));
                        }, child:Text('signup')),
                        SizedBox(
                          height: 11,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: (){
                        },
                            child:Text('ForgetPassword'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}