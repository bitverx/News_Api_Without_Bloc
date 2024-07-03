import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget{
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var email=TextEditingController();
  var password=TextEditingController();
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.email),
                      label: Text('Email'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                TextField(
                  controller: password,
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
                ),
                SizedBox(
                  height: 18,
                ),
                ElevatedButton(
                    onPressed: () async {

                      // await login(email.text.toString(), password.text.toString());
                    },
                    child: Text('SignUp')
                ),
                SizedBox(
                  height: 11,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}