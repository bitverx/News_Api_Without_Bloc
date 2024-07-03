import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../views/login/loginscreen.dart';

class splash extends StatefulWidget{
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash>with TickerProviderStateMixin {
  late final AnimationController _controller=AnimationController(
    duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 5),
        ()=> Navigator.push(context,
            MaterialPageRoute(
                builder: (context)=>LoginScreen()))
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Center(
                    child: Image(image: AssetImage('images/connections.png')),
                  ),
                ),
                builder: (BuildContext context,Widget? child){
                  return Transform.rotate(
                      angle: _controller.value * 2.0* math.pi,
                    child: child ,
                  );
                }),
            SizedBox(height: MediaQuery.of(context).size.height * .08,),
           const Align(
              alignment: Alignment.center,
              child: Text('Breaking News',
                textAlign:TextAlign.center,
                style: TextStyle(
                fontWeight: FontWeight.bold,
                  fontSize: 25
              ),),
            )

          ],
        ),
      ),
    );
  }
}