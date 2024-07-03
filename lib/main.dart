import 'package:bottom_navigation_bar/blocs/login_bloc/login_bloc.dart';
import 'package:bottom_navigation_bar/splash/splash.dart';
import 'package:bottom_navigation_bar/views/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Routes/Routes.dart';
import 'blocs/news/news_bloc.dart';
import 'blocs/selected_navigation/selection_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(),),
        BlocProvider(create: (context) => NewsBloc(),),
        BlocProvider(create: (context) => SelectionBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splash,
        routes: {
          RoutesName.splash: (context) => splash(),
          RoutesName.LoginScreen: (context) => LoginScreen(),
          // Add other routes here
        },
        home: splash(),
      ),
    );
  }
}

