import 'dart:io';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:feedback/Screens/Home/home_screen.dart';
import 'package:feedback/Screens/Login/login_screen.dart';
import 'package:feedback/Screens/IdScreen/id_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:feedback/ScopedModel/main_model.dart';
import 'package:feedback/Utitlity/app_config.dart' as app_config;

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPage createState() => new _SplashScreenPage();
}

class _SplashScreenPage extends State<SplashScreenPage> {
  bool check = false;
  bool initial = false;
  var page_second ;
  bool isLoading;
  void initState(){
    super.initState();
    _checkPage();
    
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 6,
      //navigateAfterSeconds: check ?  Home()  : (initial ? IdScreen() :  Login()),
      navigateAfterSeconds: check ?  Home()  :  Login(),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Theme.of(context).primaryColor,
      image: Image.asset("assets/images/logo.jpeg"),
    );
  }


  _checkPage() async{
        MainModel model = MainModel();
        app_config.api_url = await model.getApiUrl();
        app_config.web_url = await model.getWebUrl();
        //print(app_config.api_url);

        /*if(app_config.api_url=="" || app_config.web_url==""){
                setState(() {
                                  initial = true;
                                });
          }
        else{
                setState(() {
                                  initial = false;
                                });
                //page_second = Login();
               

          }  */

           try {
            
                      final result = await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                        app_config.userTokken=await model.getAccessTokken();
                        //print(app_config.userTokken);
                        if(app_config.userTokken!=""){
                              setState(() {
                                            //isLoading = model.isLoading;
                                          });
                                bool res =await model.getHome();
                                //print(res);
                                setState(() {
                                      check=res;
                                      //isLoading = model.isLoading;
                                  });
                          }

                        

                      
                      }
                    } on SocketException catch (_) {
                      Fluttertoast.showToast(
                          msg: "Please check your internet connection",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          backgroundColor: Color(0xff59ABC6).withOpacity(0.5),
                          textColor: Colors.white,
                          fontSize: 14.0);
                    }
       

    }

   _sendAnswer(String json_str) async{
              

                try {
                final result = await InternetAddress.lookup('google.com');
                if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                      MainModel model = MainModel();
                      var res=await model.sendAnswer(json_str);
                      if(res){
                           
                            setState(() {
                                          //page=0;       
                                          //start=1;

                                          
                                          //print(app_config.questions.length);
                                        });
                        }
                     
                                           
                  }
              } on SocketException catch (_) {
                
                }
          }  

  /*_checkPage() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String tokken=prefs.getString("tokken");
        if(tokken==null){
              check=false;
            }
        else{
            print(tokken);
            http.get(app_config.baseUrl+"profiledata/check_login",headers: {"Token-Valid": "Yhbz}-X3Hyh@-ng#^Mdng=XQHF{Z9r:s6&Y+E!4C8j@(#5#>zW","Access-Token":tokken})
                .then((onValue){
                          print(onValue.body.toString());
                          var arr=jsonDecode(onValue.body);
                          if(arr['status']==1){
                              setState(() {
                                                check=true;               
                                            });
                              
                              //app_config.userId=

                            }
                          else{
                               check=false; 
                            }  
                    });
          }    
        
    }*/
}