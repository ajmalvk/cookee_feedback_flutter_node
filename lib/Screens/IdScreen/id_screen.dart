import 'package:flutter/material.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:feedback/ScopedModel/main_model.dart';
import 'package:feedback/Screens/Home/home_screen.dart';
import 'package:feedback/Screens/Login/login_screen.dart';

class IdScreen extends StatefulWidget{
      @override
        State<StatefulWidget> createState() {
                return _IdScreenState();
            }
  }

class _IdScreenState extends State<IdScreen>{
  final _formKey = GlobalKey<FormState>();
  final th_colour_light = Colors.pink[100];
  var th_colour = Colors.pink[200];
  final th_colour_high = Colors.pink[400];
  bool _isLoading=false;
  var width_ratio;
  var height_ratio;
  TextEditingController _id_controller=new TextEditingController();
  
 
      @override
        Widget build(BuildContext context) {
           th_colour=Theme.of(context).primaryColor;
           width_ratio=MediaQuery.of(context).size.width/834.0;
           height_ratio=MediaQuery.of(context).size.height/1132.42;
          TextStyle textStyle=Theme.of(context).textTheme.title;
          // TODO: implement build
          if(_isLoading){
                return _loading(context);
            }
          else{
                return _loginBody(context);
            }  
          
        }

        Widget _loading(BuildContext context){
              return Scaffold(
                          body: Center(
                                        child: CircularProgressIndicator(
                                          valueColor: new AlwaysStoppedAnimation<Color>(th_colour),
                                        strokeWidth: 2.0,
                                        backgroundColor: th_colour,
                                      )),
                      );
          }

        Widget _loginBody(BuildContext context){
             
              TextStyle textStyle=Theme.of(context).textTheme.title;
              return Scaffold(
                       
                        body:   Form(
                                        key: _formKey,
                                        child:  Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                                            Center(
                                                                                  child: Container(
                                                                                   decoration: BoxDecoration(
                                                                                                      boxShadow: [
                                                                                                                    BoxShadow(
                                                                                                                      blurRadius: 5.0,
                                                                                                                      color: Colors.black.withOpacity(.1),
                                                                                                                      offset: Offset(6.0, 7.0),
                                                                                                                    ),
                                                                                                                  ],
                                                                                                      color: Colors.white,            
                                                                                                      borderRadius: BorderRadius.circular(10.0*height_ratio)

                                                                                                             
                                                                                                  ),
                                                                                    height: MediaQuery.of(context).size.height*0.6,
                                                                                    width: MediaQuery.of(context).size.width*0.8,
                                                                                    child: Column(
                                                                                                children: <Widget>[
                                                                                                      Container(
                                                                                                            margin: EdgeInsets.only(top: height_ratio*20.0),
                                                                                                             height: MediaQuery.of(context).size.height*0.2,
                                                                                                            width:MediaQuery.of(context).size.width*0.3,
                                                                                                            alignment: Alignment.center,
                                                                                                            child: Container(
                                                                                                                            
                                                                                                                           decoration: BoxDecoration(
                                                                                                                                              image: DecorationImage(
                                                                                                                                                            image:AssetImage("assets/images/logo.jpeg"),
                                                                                                                                                            fit: BoxFit.contain           
                                                                                                                                                      )
                                                                                                                              )
                                                                                                                    )
                                                                                                        ),
                                                                                                      Container(
                                                                                                            margin: EdgeInsets.only(top: height_ratio*40.0),
                                                                                                            alignment: Alignment.center,
                                                                                                             height: MediaQuery.of(context).size.height*0.06,
                                                                                                            width:MediaQuery.of(context).size.width*0.6,
                                                                                                            child:TextFormField(
                                                                                                            
                                                                                                              style: TextStyle(
                                                                                                                          fontSize: 22.0*width_ratio,
                                                                                                                          color: Colors.black
                                                                                                                        
                                                                                                                      ),
                                                                                                              controller: _id_controller,
                                                                                                              
                                                                                                              decoration: InputDecoration(
                                                                                                                                hintStyle: TextStyle(fontSize: 30*width_ratio),
                                                                                                                                labelText: "Enter Id",
                                                                                                                                labelStyle: TextStyle(color: Colors.grey[400],fontSize: 21.0*width_ratio),
                                                                                                                                
                                                                                                                                fillColor: Colors.white,
                                                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                                                            borderRadius: BorderRadius.circular(5.0*width_ratio),
                                                                                                                                            borderSide: BorderSide(color: Colors.grey[300],width: 0.5),
                                                                                                                                          ),
                                                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                                                            borderRadius: BorderRadius.circular(5.0*width_ratio),
                                                                                                                                            borderSide: BorderSide(color: Colors.grey[300],width: 0.5),
                                                                                                                                          ),

                                                                                                                                border: OutlineInputBorder(
                                                                                                                                            borderRadius: BorderRadius.circular(5.0*width_ratio),
                                                                                                                                            borderSide: BorderSide(color: Colors.grey[300],width: 0.5),
                                                                                                                                          )
                                                                                                                            ),
                                                                                                              validator: (value){
                                                                                                                      if(value.isEmpty){
                                                                                                                              return 'Fill Id';
                                                                                                                          }
                                                                                                                      return null;    
                                                                                                                  },              
                                                                                                            ),
                                                                                                        ),
                                                                                                     
                                                                                                     Container(
                                                                                                            margin: EdgeInsets.only(top: height_ratio*50.0),
                                                                                                            padding: EdgeInsets.all(10.0),
                                                                                                            width: MediaQuery.of(context).size.width*0.4,
                                                                                                            height: MediaQuery.of(context).size.height*0.07,
                                                                                                            child: _loginButton(context)
                                                                                                                      
                                                                                                        )         
                                                                                                  ],
                                                                                            )
                                                                                  
                                                                                  
                                                                              ),
                                                                              )
                                                                        ],
                                                                ),
                                              
                                  )
                        
                                 
                    );
          }

          Widget _loadingPage(BuildContext context){
                if(_isLoading){
                      return _loading(context);
                  }
                else{
                      return _loginBody(context);
                  }  
            }

          Widget _loginButton(BuildContext context){
              return RaisedButton(
                                                                                                                                  
                                                                                                                                      child: Text("Check ID",
                                                                                                                                                  textScaleFactor: 1.5*height_ratio,
                                                                                                                                                ),
                                                                                                                                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0*width_ratio)),
                                                                                                                                      color: Theme.of(context).primaryColor,
                                                                                                                                      textColor: Colors.white, 
                                                                                                                                      elevation: 10.0,
                                                                                                                                      onPressed: () async {
                                                                                                                                            /*if(_formKey.currentState.validate()){
                                                                                                                                                    //http.post(url);   
                                                                                                                                                    //await loginCheck(_phone_controller.text, _password_controller.text,context);
                                                                                                                                                }*/
                                                                                                                                            if(_id_controller.text==""){
                                                                                                                                                showToast("Fill Id");
                                                                                                                                              }  
                                                                                                                                          
                                                                                                                                            else{
                                                                                                                                                  _idCheck(_id_controller.text, context);
                                                                                                                                              } 
                                                                                                                                        },         
                                                                                                                                    );
            }


         _idCheck(String id,BuildContext context) async{
                setState(() {
                                  _isLoading=true;
                                });
               try {
                
                        final result = await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                              MainModel model = MainModel();
                             
                       
                              bool res=await model.checkId(id);
                              if(res){
                                      Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) => Login() ));          
                                          
                                }
                              else{
                                        showToast("Invalid Id");
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

                setState(() {
                                  _isLoading=false;
                                });  
                
            }
     

           void showToast(String msg, {int duration, int gravity}) {
                //Toast.show(msg, context, duration: duration, gravity: gravity);
                Fluttertoast.showToast(
                        msg: msg,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: Color(0xff59ABC6).withOpacity(0.5),
                        textColor: Colors.white,
                        fontSize: 14.0);
              }
  }  