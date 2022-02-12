import 'package:basic_bank_app/screens/all_users/all_users_screen.dart';
import 'package:basic_bank_app/screens/splash_screen/splash_screen.dart';
import 'package:basic_bank_app/shared/bloc_observer/bloc_observer.dart';
import 'package:basic_bank_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned (() {
    runApp(MyApp());
  },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color:mainAppColor
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(mainAppColor),
            ),

        )

      ),
      home:  SplashScreen(),
    );
  }
}


