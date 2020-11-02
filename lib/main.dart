import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'ScopedModel/main_model.dart';
import 'screens/SplashScreen/splash_screen.dart';
import 'package:flutter/services.dart';


void main() {
     /* SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));*/
      runApp(MyApp());
  }
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MainModel main =new MainModel();
    return ScopedModel(
                model: main,
                
                child: MaterialApp(
                                  title: 'WOW feedbacks',
                                  debugShowCheckedModeBanner: false,
                                  theme: ThemeData(
                                  
                                      primarySwatch: Colors.blue,
                                      primaryColor: Color(0xff27A9E3),
                                      accentColor: Color(0xffae196b),
                                      buttonColor: Color(0xffac1c06),
                                      
                                      
                                  ),
                                  home:SplashScreenPage(),
                             
                                )
            );
  }
}
