import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/login_bloc/login_bloc.dart';
import '../../../utils/validation.dart';
class EmailInputWidget extends StatelessWidget{
  final FocusNode  emailFocusNode;
  const EmailInputWidget({Key? key ,required this.emailFocusNode});
  @override
  Widget build(BuildContext context) {
    print('email');
    return  BlocBuilder<LoginBloc,LoginState>(
      buildWhen: (current,previous)=> current.email != previous.email,
        builder:(context,state){
          return TextFormField(
              focusNode: emailFocusNode,
              // controller: email,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.email),
                  label: Text('Email'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              onChanged: (value){
                context.read<LoginBloc>().add(EmailChanged(email: value));
              },
              validator: (value){
                if(value!.isEmpty){
                  return 'Enter Email';
                }
                if(!Validation.emailValidator(value)){
                  return 'Enter valid email';
                }
                return null;
                onFieldSubmitted:(value){};
              }
          );
        });
  }
  
}