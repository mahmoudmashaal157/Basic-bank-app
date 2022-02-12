import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:basic_bank_app/screens/all_users/all_users_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 400,
        pageTransitionType:PageTransitionType.leftToRightWithFade,
         splashTransition:SplashTransition.scaleTransition,
      duration: 1800,
        splash: Column(
          children: [
            Image.asset("assets/images/bank.jpg",),
            const Text("Bank App",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        nextScreen: AllUsersScreen(isTransfer: false,),
    );
  }
}
