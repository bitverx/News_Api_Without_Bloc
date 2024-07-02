import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/login_bloc/login_bloc.dart';
class PasswordInputWidget extends StatefulWidget{
  final FocusNode  passwordFocusNode;
  const PasswordInputWidget({Key? key ,required this.passwordFocusNode});
  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc,LoginState>(
          buildWhen: (current,previous)=> current.password != previous.password,
          builder: (context,state){
          print('password');
      return  TextFormField(
          focusNode: widget.passwordFocusNode,
          // controller: password,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ?  Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              label: Text('Password'),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              )
          ),
          onChanged: (value){
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
          validator: (value){
            if(value!.isEmpty){
              return 'Enter Password';
            }
            if(value.length < 6){
              return 'plz enter password greater then 6 ';
            }
            return null;
            onFieldSubmitted:(value){};
          }
      );
    });
  }
}