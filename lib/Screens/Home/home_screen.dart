//import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:feedback/ScopedModel/main_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:ui';
import 'package:feedback/Utitlity/app_config.dart' as app_config;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:feedback/Models/questioneir_model.dart';
import 'package:feedback/Screens/Login/login_screen.dart';
//import 'package:feedback/Utitlity/constants.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
    final formKey = GlobalKey<FormState>();
  final th_colour_light = Colors.pink[100];
  final th_colour = Color(0xff27A9E3);
  final th_colour_high = Colors.pink[400];
  bool _isLoading = false;
  bool _valid_email = true;
  
  var width_ratio;
  var height_ratio;
  TextEditingController _phone_controller = new TextEditingController();
  TextEditingController _name_controller = new TextEditingController();
  TextEditingController _email_controller = new TextEditingController();
  TextEditingController _address_controller = new TextEditingController();
  TextEditingController _comment_controller = new TextEditingController();
  var _language_en_bg = Color(0xff0F6F1E);
  var _language_en_txt = Colors.white;
  var _language_en_shadow = Colors.white;
  var _language_fr_bg = Colors.white;
  var _language_fr_txt = Colors.black;
  var _language_fr_shadow = Colors.grey[400];

  var page = 0;
  var start = 1;
  var success_page = 0;

  var language_selected = 0;
  var show_bottom_button = false;
  var colors_nps_master = [
    "",
    "0xFFEB3636",
    "0xFFEB3636",
    "0xFFEB3636",
    "0xFFEB3636",
    "0xFFEB3636",
    "0xFFEB3636",
    "0xFFFF8148",
    "0xFFFF8148",
    "0xFF49901F",
    "0xFF49901F"
  ];

  var profile_name = false;
  var profile_email = false;
  var profile_phone = false;
  var profile_address = false;
  var profile_comment = false;

  var profile_name_text = "";
  var profile_email_text = "";
  var profile_phone_text = "";
  var profile_address_text = "";
  var profile_comment_text = "";

  var profile_name_text_language2 = "";
  var profile_email_text_language2 = "";
  var profile_phone_text_language2 = "";
  var profile_address_text_language2 = "";
  var profile_comment_text_language2 = "";
  var _isLandscape = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
      
  ]);*/
    /*SystemChannels.lifecycle.setMessageHandler((msg){
  debugPrint('SystemChannels> $msg');
  print(AppLifecycleState.paused.toString());
  if(msg.toString()==AppLifecycleState.inactive.toString()){
    print("Waked");
          Wakelock.enable();
    }
});*/

    if (app_config.load_home_data) {
      _getHomeData();
    } else {
      page = 0;
      start = 1;
    }

    MainModel model = MainModel();
    //const oneSec = const Duration(seconds:1);
  }

  @override
  Widget build(BuildContext context) {
    //var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      setState(() {
        _isLandscape = true;
      });
    } else {
      setState(() {
        _isLandscape = false;
      });
    }
    /* SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);*/
    /*print(MediaQuery.of(context).size.width);
          print(MediaQuery.of(context).size.height);*/
    width_ratio = MediaQuery.of(context).size.width / 834;
    height_ratio = MediaQuery.of(context).size.height / 1112;
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // TODO: implement build
    return _formBody(context);
  }

  Widget _loading(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CircularProgressIndicator(
        strokeWidth: 2.0,
      )),
    );
  }

  Widget _formBody(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Form(
      key: _formKey,
      child: Container(color: Colors.white, child: _getScreenBody()),
    ))));
  }

  Widget _getScreenBody() {
    if (_isLandscape) {
      return Center(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _getScreenHeaderLandscape(),
                _getScreenBodySection(),
                _getScreenFooterLandscape()
              ],
            )),
      );
    } else {
      return Center(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _getScreenHeader(),
                _getScreenBodySection(),
                _getScreenFooter()
              ],
            )),
      );
    }
  }

  Widget _getScreenHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.3,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.3,
                //color: Colors.lime,
                child: InkWell(
                    onDoubleTap: () {
                      _logoutConfirm(context);
                    },
                    child: _loadClientLogo())),
            Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.3,
                alignment: Alignment.topRight,
                child: _getLanguageButtons())
          ]),
    );
  }

  Widget _getLanguageButtons() {
    if (app_config.has_multi_language) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.3,
          alignment: Alignment.topRight,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            InkWell(
              onTap: () {
                if (language_selected == 1) {
                  setState(() {
                    language_selected = 0;
                    _language_en_bg = Color(0xff0F6F1E);
                    _language_en_txt = Colors.white;
                    _language_fr_bg = Colors.white;
                    _language_fr_txt = Colors.black;
                    _language_en_shadow = Colors.white;
                    _language_fr_shadow = Colors.grey[300];
                  });
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 0.1,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _language_en_bg,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0 * width_ratio),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _language_en_shadow,
                      blurRadius: 1.0, // has the effect of softening the shadow
                      spreadRadius:
                          1.0, // has the effect of extending the shadow
                      offset: Offset(
                        1.0, // horizontal, move right 10
                        1.0, // vertical, move down 10
                      ),
                    )
                  ],
                ),
                child: Text(
                  app_config.language1,
                  style: TextStyle(
                      fontSize: 10 * height_ratio, color: _language_en_txt),
                  //maxLines: 1,
                ),
              ),
            ),
            SizedBox(width: 20 * width_ratio),
            InkWell(
              onTap: () {
                if (language_selected == 0) {
                  setState(() {
                    language_selected = 1;
                    _language_en_shadow = Colors.grey[300];
                    _language_fr_shadow = Colors.white;
                    _language_en_bg = Colors.white;
                    _language_en_txt = Colors.black;
                    _language_fr_bg = Color(0xff0F6F1E);
                    _language_fr_txt = Colors.white;
                  });
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 0.1,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _language_fr_bg,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0 * width_ratio),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _language_fr_shadow,
                      blurRadius: 1.0, // has the effect of softening the shadow
                      spreadRadius:
                          1.0, // has the effect of extending the shadow
                      offset: Offset(
                        1.0, // horizontal, move right 10
                        1.0, // vertical, move down 10
                      ),
                    )
                  ],
                ),
                child: Text(
                  app_config.language2,
                  style: TextStyle(
                      fontSize: 10 * height_ratio, color: _language_fr_txt),
                  //maxLines: 1,
                ),
              ),
            )
          ]));
    } else {
      /*return Container(
                                                                    width: MediaQuery.of(context).size.width*0.24,
                                                                    alignment: Alignment.topRight,
                                                                    child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: <Widget>[
                                                                                      
                                                                                        Container(
                                                                                                 height: MediaQuery.of(context).size.height*0.03,
                                                                                                  width: MediaQuery.of(context).size.width*0.1,
                                                                                                color: Colors.white,
                                                                                                child:  RaisedButton(
                                                                                                                                  
                                                                                                                                      child: Text(app_config.language1,
                                                                                                                                                   style: TextStyle(fontSize: 10*height_ratio),     
                                                                                                                                                       maxLines: 1,
                                                                                                                                                ),
                                                                                                                                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0*width_ratio)),
                                                                                                                                      color: _language_en_bg,
                                                                                                                                      textColor: _language_en_txt, 
                                                                                                                                      elevation: 3.0,
                                                                                                                                      onPressed: (){
                                                                                                                                                    
                                                                                                                                                    if(language_selected==1){
                                                                                                                                                            setState(() {
                                                                                                                                                                            language_selected=0;
                                                                                                                                                                            _language_en_bg= Colors.black;
                                                                                                                                                                          _language_en_txt = Colors.white;
                                                                                                                                                                          _language_fr_bg = Colors.white;
                                                                                                                                                                          _language_fr_txt=Colors.black;                                                                                                                                                    
                                                                                                                                                                      });
                                                                                                                                                        }
                                                                                                                                                   

                                                                                                                                            },
                                                                                                                                    )
                                                                                          ),
                                                                                      
                                                                                                                                   
                                                                                                                                
                                                                                  ]
                                                                            )
                                                                );*/
      return Container();
    }
  }

  Widget _loadClientLogo() {
    if (app_config.company_logo_exist) {
      
      return Center(
          child: Image.network(
        app_config.company_logo,
        fit: BoxFit.cover,
      ));
    } else {
      return Center(
          child: Image.asset(
        "assets/images/client-logo.png",
        fit: BoxFit.cover,
      ));
    }
  }

  Widget _getScreenFooter() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Row(children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width * 0.375,
            height: MediaQuery.of(context).size.height * 0.08,
            alignment: Alignment.centerLeft,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Image.asset("assets/images/logo.jpeg",
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      colorBlendMode: BlendMode.modulate),
                ))),
        Container(
            width: MediaQuery.of(context).size.width * 0.15,
            alignment: Alignment.center,
            child: _getNextButton()),
        Container(
          width: MediaQuery.of(context).size.width * 0.375,
          alignment: Alignment.centerRight,
          child: Container(
              child: InkWell(
            onTap: () {
              setState(() {
                page++;
              });
            },
            child: Container(
              //color: Colors.grey,
              width: MediaQuery.of(context).size.width * 0.1,
              child: Center(
                child: AutoSizeText(
                  "Skip",
                  style: TextStyle(fontSize: 20 * height_ratio),
                ),
              ),
            ),
          )),
        ),
      ]),
    );
  }

  Widget _getNextButton() {
    if (show_bottom_button) {
      return InkWell(
          onTap: () {
            setState(() {
              page++;
            });
          },
          child: Container(
            width: 150 * width_ratio,
            height: 60 * height_ratio,
            margin: EdgeInsets.only(
                top: 20.0 * height_ratio, bottom: 20.0 * height_ratio),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5.0,
                    color: Color(0xff0F6F1E).withOpacity(0.1),
                    offset: Offset(6.0, 7.0),
                  ),
                ],
                color: Color(0xff0F6F1E),
                borderRadius: BorderRadius.circular(17.0 * height_ratio)),
            child: Text(
              "NEXT",
              style: TextStyle(fontSize: 17 * width_ratio, color: Colors.white),
            ),

            /*child:Icon(Icons.arrow_forward,
                                                                                                                                                                  color: Colors.white,
                                                                                                                                                                  size: 30.0*height_ratio,
                                                                                                                                                              ),*/
          ));
    } else {
      return Container();
    }
  }

  Widget _getScreenBodySection() {
    return Container(alignment: Alignment.center, child: _get_body_section());
  }

  Widget _get_body_section() {
    /*if(page==0){
              return _questionsSectionMain();
          }
        else if(page==1){
              return _overAllSectionMain();
          }  
        else if(page==2){
              return _personalDetailsSectionMain();
          }    
        else{
              return _ratingSectionMain();
          }*/
    if (start == 1) {
     
      if (page < app_config.questions.length) {
        
        if (app_config.questions[page].type == "1") {
           
          if (_isLandscape) {
            return _overAllSectionMainLandscape();
          } else {
            return _overAllSectionMain();
          }
        } else if (app_config.questions[page].type == "2") {
          if (_isLandscape) {
            return _ratingSectionNpsMainLandscape();
          } else {
            return _ratingSectionNpsMain();
          }
        } else if (app_config.questions[page].type == "3") {
          if (_isLandscape) {
            return _questionsSectionMainLandscape();
          } else {
            return _questionsSectionMain();
          }
        } else if (app_config.questions[page].type == "4") {
          return _personalDetailsSectionMain();
        } else if (app_config.questions[page].type == "5") {
          if (_isLandscape) {
            return _reasoningSectionMainLandscape();
          } else {
            return _reasoningSectionMain();
          }
        }
      } else if (success_page == 1) {
        setState(() {});
        return _successSectionMain();
      } else {
        List<Map<String, dynamic>> answers = [];
        var i = 0;
        for (var qu in app_config.questions) {
          var j = 0;
          for (var squ in qu.questions) {
            //cur["QuestionTypeID"]=qu.type.toString();
            Map<String, dynamic> cur = {};
            cur = {
              "QuestionTypeID": qu.type,
              "QuestionID": squ.id,
              "Answer": squ.answer,
              "FieldID": squ.fieldId
            };
           // print(cur);
            answers.add(cur);
            //print(answers);
            setState(() {
              app_config.questions[i].questions[j].answer = "";
            });
            j++;
          }
          i++;
        }
        List<Map<String, dynamic>> reasons = [];
        var k = 0;
        for (var re in app_config.reasons) {
          if (re.selected) {
            var cur = {
              "ReasonQuestionID": re.questionId.toString(),
              "ReasonAnswerID": re.id.toString()
            };
            reasons.add(cur);
            setState(() {
              app_config.reasons[k].selected = false;
            });
          }
          k++;
        }
        var json_string =
            json.encode({"answers": answers, "reasonAnswers": reasons});

            //print(json_string);
        _sendAnswer(json_string);
        return _loadingSectionMain();
      }
    } else {
      return _loadingSectionMain();
    }
  }

  ///Success Page
  Widget _successSectionMain() {
    return Container(
        margin: EdgeInsets.only(
            top: 20.0 * height_ratio, bottom: 20.0 * height_ratio),
        height: MediaQuery.of(context).size.height * 0.7,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              alignment: Alignment.center,
              child: Text(
                app_config.thank_you_text,
                style: TextStyle(
                    fontSize: 40 * width_ratio,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(app_config.thank_you_image),
                      fit: BoxFit.contain)),
            )
          ],
        ));
  }

  ///

  Widget _loadingSectionMain() {
    return Container(
        margin: EdgeInsets.only(
            top: 20.0 * height_ratio, bottom: 20.0 * height_ratio),
        height: MediaQuery.of(context).size.height * 0.6,
        alignment: Alignment.center,
        child: Center(
            child: CircularProgressIndicator(
          strokeWidth: 2.0,
        )));
  }

  ///Over all Expierience
  Widget _overAllSectionMain() {
    var smily_question =
        app_config.questions[page].questions[0].questionLanguage1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      smily_question =
          app_config.questions[page].questions[0].questionLanguage2;
    }
    setState(() {
      show_bottom_button = false;
    });
    return Container(
        margin: EdgeInsets.only(
            top: 20.0 * height_ratio, bottom: 20.0 * height_ratio),
        height: MediaQuery.of(context).size.height * 0.6,
        alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 40.0 * height_ratio),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Center(
                  child: AutoSizeText(
                    smily_question,
                    style: TextStyle(fontSize: 28 * height_ratio),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                  //color: Colors.red,
                  child: _overAllSectionSmily()),
            ]));
  }

  Widget _overAllSectionSmily() {
    if (app_config.questions[page].questions[0].smileyCount == "5") {
      return _overAllSectionSmilyFive();
    } else {
      return _overAllSectionSmilyThree();
    }
  }

  Widget _overAllSectionSmilyThree() {
    var image1 = app_config.questions[page].questions[0].imageUrl1;
    var image2 = app_config.questions[page].questions[0].imageUrl2;
    var image3 = app_config.questions[page].questions[0].imageUrl3;
    var image_text1 =
        app_config.questions[page].questions[0].rateText1Language1;
    var image_text2 =
        app_config.questions[page].questions[0].rateText2Language1;
    var image_text3 =
        app_config.questions[page].questions[0].rateText3Language1;
    //print(image_text3);
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      image_text1 = app_config.questions[page].questions[0].rateText1Language2;
      image_text2 = app_config.questions[page].questions[0].rateText2Language2;
      image_text3 = app_config.questions[page].questions[0].rateText3Language2;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _overAllSectionSmilyRow(image_text1, image1, "1", 3),
        _overAllSectionSmilyRow(image_text2, image2, "2", 3),
        _overAllSectionSmilyRow(image_text3, image3, "3", 3)
      ],
    );
  }

  Widget _overAllSectionSmilyRow(
      String text, String image, String position, int smily_count) {
    if (smily_count == 5) {}
    return InkWell(
      onTap: () {
        app_config.questions[page].questions[0].answer = position;
        setState(() {
          page++;
        });
      },
      child: Container(
        //color: Colors.blue,
        //margin: EdgeInsets.only(left: margin_row*width_ratio,right:margin_row*width_ratio),
        height: MediaQuery.of(context).size.height * 0.16,

        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.15,
                //color: Colors.blue,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.contain)),
              ),
              Container(
                  //color: Colors.purple,
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(
                      child: AutoSizeText(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0 * height_ratio,
                      //color: th_colour
                    ),
                  )))
            ]),
      ),
    );
  }

  Widget _overAllSectionSmilyFive() {
    var image1 = app_config.questions[page].questions[0].imageUrl1;
    var image2 = app_config.questions[page].questions[0].imageUrl2;
    var image3 = app_config.questions[page].questions[0].imageUrl3;
    var image4 = app_config.questions[page].questions[0].imageUrl4;
    var image5 = app_config.questions[page].questions[0].imageUrl5;
    var image_text1 =
        app_config.questions[page].questions[0].rateText1Language1;
    var image_text2 =
        app_config.questions[page].questions[0].rateText2Language1;
    var image_text3 =
        app_config.questions[page].questions[0].rateText3Language1;
    var image_text4 =
        app_config.questions[page].questions[0].rateText4Language1;
    var image_text5 =
        app_config.questions[page].questions[0].rateText5Language1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      image_text1 = app_config.questions[page].questions[0].rateText1Language2;
      image_text2 = app_config.questions[page].questions[0].rateText2Language2;
      image_text3 = app_config.questions[page].questions[0].rateText3Language2;
      image_text4 = app_config.questions[page].questions[0].rateText4Language2;
      image_text5 = app_config.questions[page].questions[0].rateText5Language2;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _overAllSectionSmilyRow(image_text1, image1, "1", 5),
        _overAllSectionSmilyRow(image_text2, image2, "2", 5),
        _overAllSectionSmilyRow(image_text3, image3, "3", 5),
        _overAllSectionSmilyRow(image_text4, image4, "4", 5),
        _overAllSectionSmilyRow(image_text5, image5, "5", 5)
      ],
    );
  }

  //get over all section
  Widget _ratingSectionNpsMain() {
    return Container(
        margin: EdgeInsets.only(
            top: 20.0 * height_ratio, bottom: 20.0 * height_ratio),
        height: MediaQuery.of(context).size.height * 0.6,
        alignment: Alignment.center,
        //color: Colors.orangeAccent,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_getRatingSection()]));
  }

  Widget _getRatingSection() {
    var smily_question =
        app_config.questions[page].questions[0].questionLanguage1;
    var start_text = app_config.questions[page].questions[0].startTextLanguage1;
    var end_text = app_config.questions[page].questions[0].endTextLanguage1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      smily_question =
          app_config.questions[page].questions[0].questionLanguage2;
      start_text = app_config.questions[page].questions[0].startTextLanguage2;
      end_text = app_config.questions[page].questions[0].endTextLanguage2;
    } 
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 40.0 * height_ratio),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: AutoSizeText(
              smily_question,
              style: TextStyle(fontSize: 28 * height_ratio),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getNpsItemSingle(1),
            _getNpsItemSingle(2),
            _getNpsItemSingle(3),
            _getNpsItemSingle(4),
            _getNpsItemSingle(5),
            _getNpsItemSingle(6),
            _getNpsItemSingle(7),
            _getNpsItemSingle(8),
            _getNpsItemSingle(9),
            _getNpsItemSingle(10),
          ],
        ),
        Row(children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * 0.9 * 0.5,
              height: MediaQuery.of(context).size.height * 0.04,
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 10.0 * width_ratio),
                  child: AutoSizeText(
                    start_text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0 * height_ratio,
                      //color: th_colour
                    ),
                  ))),
          Container(
              width: MediaQuery.of(context).size.width * 0.9 * 0.5,
              height: MediaQuery.of(context).size.height * 0.04,
              //color: Colors.red,
              alignment: Alignment.centerRight,
              child: Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: AutoSizeText(
                    end_text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0 * height_ratio,
                      //color: th_colour
                    ),
                  ))),
        ])
      ],
    );
  }

  Widget _getNpsItemSingle(int position) {
    return InkWell(
        onTap: () {
          setState(() {
            app_config.questions[page].questions[0].answer =
                position.toString();
            page++;
          });
        },
        child: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            //color: Colors.lime,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.08,
              //margin: EdgeInsets.only(left: 5,right: 5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(int.parse(colors_nps_master[position]))),
              child: Center(
                child: AutoSizeText(
                  position.toString(),
                  style: TextStyle(
                      fontSize: 25 * height_ratio,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )));
  }

  ////
  ///Questions Section
  Widget _questionsSectionMain() {
    setState(() {
      show_bottom_button = true;
    });
    return Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
        height: MediaQuery.of(context).size.height * 0.6,
        //color: Colors.lime,
        alignment: Alignment.center,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[_questionsHead(), _questionsBody()])));
  }

  Widget _questionsHead() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9 * 0.5,
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9 * 0.5,
            height: MediaQuery.of(context).size.height * 0.05,
            child: _questionHeadTitles(),
          )
        ],
      ),
    );
  }

  Widget _questionHeadTitles() {
    var image_text1 =
        app_config.questions[page].questions[0].rateText1Language1;
    var image_text2 =
        app_config.questions[page].questions[0].rateText2Language1;
    var image_text3 =
        app_config.questions[page].questions[0].rateText3Language1;
    var image_text4 =
        app_config.questions[page].questions[0].rateText4Language1;
    var image_text5 =
        app_config.questions[page].questions[0].rateText5Language1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      image_text1 = app_config.questions[page].questions[0].rateText1Language2;
      image_text2 = app_config.questions[page].questions[0].rateText2Language2;
      image_text3 = app_config.questions[page].questions[0].rateText3Language2;
      image_text4 = app_config.questions[page].questions[0].rateText4Language2;
      image_text5 = app_config.questions[page].questions[0].rateText5Language2;
      //print(app_config.questions[page].questions.length);
    }
    if (app_config.questions[page].questions[0].smileyCount == "5") {
      return Row(
        children: <Widget>[
          _questionHeadTitleSingle(image_text1),
          _questionHeadTitleSingle(image_text2),
          _questionHeadTitleSingle(image_text3),
          _questionHeadTitleSingle(image_text4),
          _questionHeadTitleSingle(image_text5),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(
                  left: 20.0 * width_ratio, right: 20.0 * width_ratio),
              child: _questionHeadTitleSingle(image_text1)),
          Container(
            margin: EdgeInsets.only(
                left: 20.0 * width_ratio, right: 20.0 * width_ratio),
            child: _questionHeadTitleSingle(image_text2),
          ),
          Container(
              margin: EdgeInsets.only(
                  left: 20.0 * width_ratio, right: 20.0 * width_ratio),
              child: _questionHeadTitleSingle(image_text3))
        ],
      );
    }
  }

  Widget _questionHeadTitleSingle(String text) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9 * 0.5 / 5,
      alignment: Alignment.center,
      //color: Colors.blue,
      child: Text(
        text,
        style: TextStyle(fontSize: 10 * width_ratio),
        textAlign: TextAlign.center,
      ),
    );
  }

  /*Widget _questionsBody1(){
          return Container(
                             alignment: Alignment.center,
                              child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                    _questionItemRow(0),
                                                    _questionItemRow(1),
                                                    _questionItemRow(2),
                                                    _questionItemRow(3),
                                                    _questionItemRow(4)
                                              ]
                                        )
                      );   
      }*/
  Widget _questionsBody() {
    return Expanded(
        child: ListView.builder(
            itemCount: app_config.questions[page].questions.length,
            itemBuilder: (BuildContext context, int position) {
              return _questionItemRow(position);
            }));
  }

  Widget _questionItemRow(int position) {
    var bg_colour = Colors.white;
    if (position % 2 == 0) {
      bg_colour = Colors.grey[100];
    }
    var question =
        app_config.questions[page].questions[position].questionLanguage1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      question =
          app_config.questions[page].questions[position].questionLanguage2;
    }

    return Container(
      padding: EdgeInsets.only(left: 0),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.07,
      color: bg_colour,
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9 * 0.5,
            height: MediaQuery.of(context).size.height * 0.05,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 7),
            child: Text(
              
              question,
              style: TextStyle(fontSize: 14 * height_ratio),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9 * 0.5,
            height: MediaQuery.of(context).size.height * 0.05,
            child: _questionItemRowSmileys(position),
          )
        ],
      ),
    );
  }

  Widget _questionItemRowSmileys(int position) {
    if (app_config.questions[page].questions[position].smileyCount == "5") {
      return _questionItemRowSmileysFive(position);
    } else {
      return _questionItemRowSmileysThree(position);
    }
  }

  Widget _questionItemRowSmileysThree(int position) {
    return Row(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(
                left: 20.0 * width_ratio, right: 20.0 * width_ratio),
            child: _questionItemRowSmileysSingle(position, 1)),
        Container(
            margin: EdgeInsets.only(
                left: 20.0 * width_ratio, right: 20.0 * width_ratio),
            child: _questionItemRowSmileysSingle(position, 2)),
        Container(
            margin: EdgeInsets.only(
                left: 20.0 * width_ratio, right: 20.0 * width_ratio),
            child: _questionItemRowSmileysSingle(position, 3)),
      ],
    );
  }

  Widget _questionItemRowSmileysFive(int position) {
    return Row(
      children: <Widget>[
        _questionItemRowSmileysSingle(position, 1),
        _questionItemRowSmileysSingle(position, 2),
        _questionItemRowSmileysSingle(position, 3),
        _questionItemRowSmileysSingle(position, 4),
        _questionItemRowSmileysSingle(position, 5)
      ],
    );
  }

  Widget _questionItemRowSmileysSingle(int position, int image_position) {
    var cur_image = app_config.questions[page].questions[position].imageUrl1;
    if (image_position == 1) {
      cur_image = app_config.questions[page].questions[position].imageUrl1;
    } else if (image_position == 2) {
      cur_image = app_config.questions[page].questions[position].imageUrl2;
    } else if (image_position == 3) {
      cur_image = app_config.questions[page].questions[position].imageUrl3;
    } else if (image_position == 4) {
      cur_image = app_config.questions[page].questions[position].imageUrl4;
    } else if (image_position == 5) {
      cur_image = app_config.questions[page].questions[position].imageUrl5;
    }
    var image_opacity = 0.5;
    if (app_config.questions[page].questions[position].answer ==
        image_position.toString()) {
      image_opacity = 0;
    }
    return Container(
        width: MediaQuery.of(context).size.width * 0.9 * 0.5 / 5,
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            setState(() {
              app_config.questions[page].questions[position].answer =
                  image_position.toString();
            });
          },
          /*child: Image.network(
                                                                          cur_image,
                                                                          scale: 1.2,
                                                                        )*/
          child: Container(
              width: MediaQuery.of(context).size.width * 0.9 * 0.45 / 5,
              height: MediaQuery.of(context).size.height * 0.05,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(cur_image), fit: BoxFit.contain)),
              //child: _questionItemRowSmileysSingleTick(position, image_position)
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9 * 0.45 / 5,
                height: MediaQuery.of(context).size.height * 0.07,
                color: Colors.white.withOpacity(image_opacity),
              )),
        ));
  }

  Widget _questionItemRowSmileysSingleTick(int position, int image_position) {
    if (app_config.questions[page].questions[position].answer ==
        image_position.toString()) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.9 * 0.45 * 0.3 / 5,
          height: MediaQuery.of(context).size.height * 0.03,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/tick.png"),
                  fit: BoxFit.contain)));
    } else {
      return Container();
    }
  }

  ///
  ///Add personal Details
  Widget _personalDetailsSectionMain() {
     setState(() {
      show_bottom_button = false;
    });
    profile_name = false;
    profile_email = false;
    profile_phone = false;
    profile_address = false;
    profile_address = false;
    profile_name_text = "Name";
    profile_email_text = "Email";
    profile_phone_text = "Phone";
    profile_address_text = "Address";
    profile_address_text = "Comment";
    for (var pro in app_config.questions[page].questions) {
      if (pro.fieldId == "1") {
        profile_name = true;
        profile_name_text = pro.questionLanguage1;
        if (app_config.questions[page].multipleLanguage == 1 &&
            language_selected == 1) {
          profile_name_text = pro.questionLanguage2;
        }
      } else if (pro.fieldId == "3") {
        profile_email = true;
        profile_email_text = pro.questionLanguage1;
        if (app_config.questions[page].multipleLanguage == 1 &&
            language_selected == 1) {
          profile_email_text = pro.questionLanguage2;
        }
      } else if (pro.fieldId == "2") {
        profile_phone = true;
        profile_phone_text = pro.questionLanguage1;
        if (app_config.questions[page].multipleLanguage == 1 &&
            language_selected == 1) {
          profile_phone_text = pro.questionLanguage2;
        }
      } else if (pro.fieldId == "4") {
        profile_address = true;
        profile_address_text = pro.questionLanguage1;
        if (app_config.questions[page].multipleLanguage == 1 &&
            language_selected == 1) {
          profile_address_text = pro.questionLanguage2;
        }
      } else if (pro.fieldId == "5") {
        profile_comment = true;
        profile_comment_text = pro.questionLanguage1;
        if (app_config.questions[page].multipleLanguage == 1 &&
            language_selected == 1) {
          profile_comment_text = pro.questionLanguage2;
        }
      }
    }
    if (_isLandscape) {
      return Container(
          //margin: EdgeInsets.only(top: 20.0*height_ratio,bottom: 20.0*height_ratio),
          margin: EdgeInsets.only(top: 10.0 * height_ratio),
          height: MediaQuery.of(context).size.height * 0.6,
          alignment: Alignment.center,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _personalDetailsQuestionsLandscape(),
                _personalDetailsButtonLandscape()
              ]));
    } else {
      return Container(
          //margin: EdgeInsets.only(top: 20.0*height_ratio,bottom: 20.0*height_ratio),
          margin: EdgeInsets.only(top: 150.0 * height_ratio),
          height: MediaQuery.of(context).size.height * 0.6,
          alignment: Alignment.center,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _personalDetailsQuestions(),
                _personalDetailsButton()
              ]));
    }
  }

  Widget _personalDetailsQuestions() {

     

    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _personalDetailsQuestionsRow1(),
        _personalDetailsQuestionsRow2()
      ],
    ));
  }

  Widget _personalDetailsQuestionsRow1() {
    if (profile_name || profile_email || profile_address) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.9 * 0.5,
          child: Container(
              margin: EdgeInsets.only(right: 10.0),
              child: Column(
                children: <Widget>[
                  _personalDetailsQuestionsRow1Name(),
                  _personalDetailsQuestionsRow1Phone(),
                  _personalDetailsQuestionsRow1Email(),
                ],
              )));
    } else {
      return Container();
    }
  }

  Widget _personalDetailsQuestionsRow1Name() {
    if (profile_name) {
      return Container(
          //height: MediaQuery.of(context).size.height*0.2,

          child: Material(
        elevation: 1.0,
        //shadowColor: Colors.grey[200],
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        child: TextFormField(
          style: TextStyle(fontSize: 15.0 * width_ratio, color: Colors.black),
          controller: _name_controller,
          decoration: InputDecoration(
              labelText: profile_name_text,
              labelStyle: TextStyle(
                  color: Colors.grey[400], fontSize: 13.0 * width_ratio),
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.4),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0 * width_ratio),
              )),
         
        ),
      ));
    } else {
      return Container();
    }
  }

  ///profile email
  Widget _personalDetailsQuestionsRow1Phone() {
    if (profile_phone) {
      return Container(
          //height: MediaQuery.of(context).size.height*0.2,
          margin: EdgeInsets.only(top: 10.0 * height_ratio),
          child: Material(
            elevation: 1.0,
            //shadowColor: Colors.grey[200],
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            child: TextFormField(
              style:
                  TextStyle(fontSize: 13.0 * width_ratio, color: Colors.black),
              controller: _phone_controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                BlacklistingTextInputFormatter(new RegExp('[\\-|\\ ]'))
              ],
              decoration: InputDecoration(
                  labelText: profile_phone_text,
                  labelStyle: TextStyle(
                      color: Colors.grey[400], fontSize: 13.0 * width_ratio),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0 * width_ratio),
                  )),
              validator: (value) {
                /*if(value.isEmpty){
                                                                                                                                      return 'Fill Phone';
                                                                                                                                  }
                                                                                                                  return null;*/
              },
            ),
          ));
    } else {
      return Container();
    }
  }

  Widget _personalDetailsQuestionsRow1Email() {
    if (profile_email) {
      return Container(
          //height: MediaQuery.of(context).size.height*0.2,
          margin: EdgeInsets.only(top: 10.0 * height_ratio),
          child: Material(
            elevation: 1.0,
            //shadowColor: Colors.grey[200],
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            child: TextFormField(
              style:
                  TextStyle(fontSize: 13.0 * width_ratio, color: Colors.black),
              controller: _email_controller,
              decoration: InputDecoration(
                  labelText: profile_email_text,
                  labelStyle: TextStyle(
                      color: Colors.grey[400], fontSize: 13.0 * width_ratio),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0 * width_ratio),
                  )),
                onChanged: (val) {
               if(!_isEmailValid(val) && val.isNotEmpty){
                 print("Not VALID");
                 setState(() {
                    _valid_email =false;
                 });
               }else{
                  setState(() {
                    _valid_email =true;
                 });
               }
             },
            ),
          ));
    } else {
      return Container();
    }
  }

  Widget _personalDetailsQuestionsRow2() {
    if (profile_address || profile_comment) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.9 * 0.5,
          //color: Colors.lightGreen,
          child: Column(
            children: <Widget>[
              _personalDetailsQuestionsRow2Address(),
              _personalDetailsQuestionsRow2Comment()
            ],
          ));
    } else {
      return Container();
    }
  }

  Widget _personalDetailsQuestionsRow2Address() {
    if (profile_address) {
      return Container(
          margin: EdgeInsets.only(left: 10.0 * width_ratio),
          height: MediaQuery.of(context).size.height * 0.1,
          child: Material(
            elevation: 1.0,
            //shadowColor: Colors.grey[200],
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            child: TextFormField(
              style:
                  TextStyle(fontSize: 13.0 * width_ratio, color: Colors.black),
              controller: _address_controller,
              maxLines: 5,
              decoration: InputDecoration(
                  labelText: profile_address_text,
                  labelStyle: TextStyle(
                      color: Colors.grey[400], fontSize: 13.0 * width_ratio),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0 * width_ratio),
                  )),
              validator: (value) {
                /*if(value.isEmpty){
                                                                                                    return 'Fill Phone';
                                                                                                }
                                                                                return null;*/
              },
            ),
          ));
    } else {
      return Container();
    }
  }

  Widget _personalDetailsQuestionsRow2Comment() {
    if (profile_comment) {
      return Container(
          margin:
              EdgeInsets.only(left: 10.0 * width_ratio, top: 5 * height_ratio),
          height: MediaQuery.of(context).size.height * 0.1,
          child: Material(
            elevation: 1.0,
            //shadowColor: Colors.grey[200],
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            child: TextFormField(
              style:
                  TextStyle(fontSize: 13.0 * width_ratio, color: Colors.black),
              controller: _comment_controller,
              maxLines: 5,
              decoration: InputDecoration(
                  labelText: profile_comment_text,
                  labelStyle: TextStyle(
                      color: Colors.grey[400], fontSize: 13.0 * width_ratio),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0 * width_ratio),
                  )),
              validator: (value) {
                /*if(value.isEmpty){
                                                                                                    return 'Fill Phone';
                                                                                                }
                                                                                return null;*/
              },
            ),
          ));
    } else {
      return Container();
    }
  }

  Widget _personalDetailsButton() {
    return Container(
        margin: EdgeInsets.only(top: 30.0 * height_ratio),
        width: MediaQuery.of(context).size.width * 0.28,
        height: MediaQuery.of(context).size.height * 0.08,
        //color: Colors.purple,
        child: InkWell(
            onTap: () {
             if(_valid_email == false){
                   showToast("Invalid Email");
            }else{
               print("iouoiuoiuoiuoiui");
              var i = 0;
              for (var pro in app_config.questions[page].questions) {
                if (pro.fieldId == "1") {
                  app_config.questions[page].questions[i].answer =
                      _name_controller.text;
                  _name_controller.text = "";
                } else if (pro.fieldId == "3") {
                  app_config.questions[page].questions[i].answer =
                      _email_controller.text;
                  _email_controller.text = "";
                } else if (pro.fieldId == "2") {
                  app_config.questions[page].questions[i].answer =
                      _phone_controller.text;
                  _phone_controller.text = "";
                } else if (pro.fieldId == "4") {
                  app_config.questions[page].questions[i].answer =
                      _address_controller.text;
                  _address_controller.text = "";
                } else if (pro.fieldId == "5") {
                  app_config.questions[page].questions[i].answer =
                      _comment_controller.text;
                  _comment_controller.text = "";
                }
                i++;
              }
              setState(() {
                page++;
              });
            }
            },
            child: Container(
              width: 150 * width_ratio,
              height: 60 * height_ratio,
              margin: EdgeInsets.only(
                  top: 20.0 * height_ratio, bottom: 20.0 * height_ratio),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.0,
                      color: Color(0xff0F6F1E).withOpacity(0.1),
                      offset: Offset(6.0, 7.0),
                    ),
                  ],
                  color: Color(0xff0F6F1E),
                  borderRadius: BorderRadius.circular(17.0 * height_ratio)),
              child: Text(
                "NEXT",
                style:
                    TextStyle(fontSize: 17 * width_ratio, color: Colors.white),
              ),

              /*child:Icon(Icons.arrow_forward,
                                                                                                                                                                  color: Colors.white,
                                                                                                                                                                  size: 30.0*height_ratio,
                                                                                                                                                              ),*/
            )));
  }

  ///
  ///
  ///Landscape
  Widget _getScreenHeaderLandscape() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.17,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width * 0.3,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width * 0.3,
                child: InkWell(
                  onDoubleTap: () {
                    _logoutConfirm(context);
                  },
                  child: _loadClientLogo(),
                )),
            Container(
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width * 0.3,
                alignment: Alignment.topRight,
                child: _getLanguageButtonsLandscape())
          ]),
    );
  }

  Widget _getLanguageButtonsLandscape() {
    if (app_config.has_multi_language) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.3,
          alignment: Alignment.topRight,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            InkWell(
              onTap: () {
                if (language_selected == 1) {
                  setState(() {
                    language_selected = 0;
                    _language_en_bg = Color(0xff0F6F1E);
                    _language_en_txt = Colors.white;
                    _language_fr_bg = Colors.white;
                    _language_fr_txt = Colors.black;
                    _language_en_shadow = Colors.white;
                    _language_fr_shadow = Colors.grey[300];
                  });
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.08,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _language_en_bg,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0 * width_ratio),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _language_en_shadow,
                      blurRadius: 1.0, // has the effect of softening the shadow
                      spreadRadius:
                          1.0, // has the effect of extending the shadow
                      offset: Offset(
                        1.0, // horizontal, move right 10
                        1.0, // vertical, move down 10
                      ),
                    )
                  ],
                ),
                child: Text(
                  app_config.language1,
                  style: TextStyle(
                      fontSize: 15 * height_ratio, color: _language_en_txt),
                  //maxLines: 1,
                ),
              ),
            ),
            SizedBox(width: 20 * width_ratio),
            InkWell(
              onTap: () {
                if (language_selected == 0) {
                  setState(() {
                    language_selected = 1;
                    _language_en_shadow = Colors.grey[300];
                    _language_fr_shadow = Colors.white;
                    _language_en_bg = Colors.white;
                    _language_en_txt = Colors.black;
                    _language_fr_bg = Color(0xff0F6F1E);
                    _language_fr_txt = Colors.white;
                  });
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.08,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _language_fr_bg,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0 * width_ratio),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _language_fr_shadow,
                      blurRadius: 1.0, // has the effect of softening the shadow
                      spreadRadius:
                          1.0, // has the effect of extending the shadow
                      offset: Offset(
                        1.0, // horizontal, move right 10
                        1.0, // vertical, move down 10
                      ),
                    )
                  ],
                ),
                child: Text(
                  app_config.language2,
                  style: TextStyle(
                      fontSize: 15 * height_ratio, color: _language_fr_txt),
                  //maxLines: 1,
                ),
              ),
            )
          ]));
    } else {
      /*return Container(
                                                                    width: MediaQuery.of(context).size.width*0.24,
                                                                    alignment: Alignment.topRight,
                                                                    child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: <Widget>[
                                                                                      
                                                                                        Container(
                                                                                                 height: MediaQuery.of(context).size.height*0.03,
                                                                                                  width: MediaQuery.of(context).size.width*0.1,
                                                                                                color: Colors.white,
                                                                                                child:  RaisedButton(
                                                                                                                                  
                                                                                                                                      child: Text(app_config.language1,
                                                                                                                                                   style: TextStyle(fontSize: 10*height_ratio),     
                                                                                                                                                       maxLines: 1,
                                                                                                                                                ),
                                                                                                                                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0*width_ratio)),
                                                                                                                                      color: _language_en_bg,
                                                                                                                                      textColor: _language_en_txt, 
                                                                                                                                      elevation: 3.0,
                                                                                                                                      onPressed: (){
                                                                                                                                                    
                                                                                                                                                    if(language_selected==1){
                                                                                                                                                            setState(() {
                                                                                                                                                                            language_selected=0;
                                                                                                                                                                            _language_en_bg= Colors.black;
                                                                                                                                                                          _language_en_txt = Colors.white;
                                                                                                                                                                          _language_fr_bg = Colors.white;
                                                                                                                                                                          _language_fr_txt=Colors.black;                                                                                                                                                    
                                                                                                                                                                      });
                                                                                                                                                        }
                                                                                                                                                   

                                                                                                                                            },
                                                                                                                                    )
                                                                                          ),
                                                                                      
                                                                                                                                   
                                                                                                                                
                                                                                  ]
                                                                            )
                                                                );*/
      return Container();
    }
  }

  Widget _getScreenFooterLandscape() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Row(children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width * 0.375,
            height: MediaQuery.of(context).size.height * 0.08,
            alignment: Alignment.centerLeft,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Image.asset("assets/images/logo.jpeg",
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      colorBlendMode: BlendMode.modulate),
                ))),
        Container(
            width: MediaQuery.of(context).size.width * 0.15,
            alignment: Alignment.center,
            child: _getNextButtonLandscape()),
        Container(
          width: MediaQuery.of(context).size.width * 0.375,
          alignment: Alignment.centerRight,
          child: Container(
              child: InkWell(
            onTap: () {
              setState(() {
                page++;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.1,
              child: Center(
                child: Text(
                  "Skip",
                  style: TextStyle(fontSize: 25 * height_ratio),
                ),
              ),
            ),
          )),
        ),
      ]),
    );
  }

  Widget _getNextButtonLandscape() {
    if (show_bottom_button) {
      return InkWell(
          onTap: () {
            setState(() {
              page++;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.11,
            height: MediaQuery.of(context).size.height * 0.055,
            alignment: Alignment.center,
            //margin: EdgeInsets.only(top: 20.0*height_ratio,bottom: 20.0*height_ratio),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5.0,
                    color: Color(0xff0F6F1E).withOpacity(0.1),
                    offset: Offset(6.0, 7.0),
                  ),
                ],
                color: Color(0xff0F6F1E),
                borderRadius: BorderRadius.circular(15.0 * height_ratio)),

            child: Text(
              "NEXT",
              style: TextStyle(fontSize: 12 * width_ratio, color: Colors.white),
            ),
          ));
    } else {
      return Container();
    }
  }

  ///Over all Expierience
  Widget _overAllSectionMainLandscape() {
    var smily_question =
        app_config.questions[page].questions[0].questionLanguage1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      smily_question =
          app_config.questions[page].questions[0].questionLanguage2;
    }
    setState(() {
      show_bottom_button = false;
    });
    return Container(
        margin: EdgeInsets.only(
            top: 20.0 * height_ratio, bottom: 20.0 * height_ratio),
        height: MediaQuery.of(context).size.height * 0.6,
        alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 80.0 * height_ratio),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Center(
                  child: AutoSizeText(
                    smily_question,
                    style: TextStyle(fontSize: 38 * height_ratio),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                  //color: Colors.red,
                  child: _overAllSectionSmilyLandscape()),
            ]));
  }

  Widget _overAllSectionSmilyLandscape() {
    if (app_config.questions[page].questions[0].smileyCount == "5") {
      return _overAllSectionSmilyFiveLandscape();
    } else {
      return _overAllSectionSmilyThreeLandscape();
    }
  }

  Widget _overAllSectionSmilyThreeLandscape() {
    var image1 = app_config.questions[page].questions[0].imageUrl1;
    var image2 = app_config.questions[page].questions[0].imageUrl2;
    var image3 = app_config.questions[page].questions[0].imageUrl3;
    var image_text1 =
        app_config.questions[page].questions[0].rateText1Language1;
    var image_text2 =
        app_config.questions[page].questions[0].rateText2Language1;
    var image_text3 =
        app_config.questions[page].questions[0].rateText3Language1;
    //print(image_text3);
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      image_text1 = app_config.questions[page].questions[0].rateText1Language2;
      image_text2 = app_config.questions[page].questions[0].rateText2Language2;
      image_text3 = app_config.questions[page].questions[0].rateText3Language2;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _overAllSectionSmilyRowLandscape(image_text1, image1, "1", 3),
        _overAllSectionSmilyRowLandscape(image_text2, image2, "2", 3),
        _overAllSectionSmilyRowLandscape(image_text3, image3, "3", 3)
      ],
    );
  }

  Widget _overAllSectionSmilyRowLandscape(
      String text, String image, String position, int smily_count) {
    if (smily_count == 5) {}
    return InkWell(
      onTap: () {
        app_config.questions[page].questions[0].answer = position;
        setState(() {
          page++;
        });
      },
      child: Container(
        //color: Colors.blue,
        //margin: EdgeInsets.only(left: margin_row*width_ratio,right:margin_row*width_ratio),
        height: MediaQuery.of(context).size.height * 0.2,

        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.16,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.contain)),
              ),
              Container(
                  //color: Colors.purple,
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(
                      child: AutoSizeText(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0 * height_ratio,
                      //color: th_colour
                    ),
                  )))
            ]),
      ),
    );
  }

  Widget _overAllSectionSmilyFiveLandscape() {
    var image1 = app_config.questions[page].questions[0].imageUrl1;
    var image2 = app_config.questions[page].questions[0].imageUrl2;
    var image3 = app_config.questions[page].questions[0].imageUrl3;
    var image4 = app_config.questions[page].questions[0].imageUrl4;
    var image5 = app_config.questions[page].questions[0].imageUrl5;
    var image_text1 =
        app_config.questions[page].questions[0].rateText1Language1;
    var image_text2 =
        app_config.questions[page].questions[0].rateText2Language1;
    var image_text3 =
        app_config.questions[page].questions[0].rateText3Language1;
    var image_text4 =
        app_config.questions[page].questions[0].rateText4Language1;
    var image_text5 =
        app_config.questions[page].questions[0].rateText5Language1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      image_text1 = app_config.questions[page].questions[0].rateText1Language2;
      image_text2 = app_config.questions[page].questions[0].rateText2Language2;
      image_text3 = app_config.questions[page].questions[0].rateText3Language2;
      image_text4 = app_config.questions[page].questions[0].rateText4Language2;
      image_text5 = app_config.questions[page].questions[0].rateText5Language2;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _overAllSectionSmilyRowLandscape(image_text1, image1, "1", 5),
        _overAllSectionSmilyRowLandscape(image_text2, image2, "2", 5),
        _overAllSectionSmilyRowLandscape(image_text3, image3, "3", 5),
        _overAllSectionSmilyRowLandscape(image_text4, image4, "4", 5),
        _overAllSectionSmilyRowLandscape(image_text5, image5, "5", 5)
      ],
    );
  }

  ////
  ///Nps Landscape
  //get over all section
  Widget _ratingSectionNpsMainLandscape() {
    return Container(
        margin: EdgeInsets.only(
            top: 20.0 * height_ratio, bottom: 20.0 * height_ratio),
        height: MediaQuery.of(context).size.height * 0.6,
        alignment: Alignment.center,
        //color: Colors.orangeAccent,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_getRatingSectionLandscape()]));
  }

  Widget _getRatingSectionLandscape() {
    var smily_question =
        app_config.questions[page].questions[0].questionLanguage1;
    var start_text = app_config.questions[page].questions[0].startTextLanguage1;
    var end_text = app_config.questions[page].questions[0].endTextLanguage1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      smily_question =
          app_config.questions[page].questions[0].questionLanguage2;
      start_text = app_config.questions[page].questions[0].startTextLanguage2;
      end_text = app_config.questions[page].questions[0].endTextLanguage2;
    }
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 40.0 * height_ratio),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: AutoSizeText(
              smily_question,
              style: TextStyle(fontSize: 38 * height_ratio),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getNpsItemSingleLandscape(1),
            _getNpsItemSingleLandscape(2),
            _getNpsItemSingleLandscape(3),
            _getNpsItemSingleLandscape(4),
            _getNpsItemSingleLandscape(5),
            _getNpsItemSingleLandscape(6),
            _getNpsItemSingleLandscape(7),
            _getNpsItemSingleLandscape(8),
            _getNpsItemSingleLandscape(9),
            _getNpsItemSingleLandscape(10),
          ],
        ),
        Row(children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * 0.9 * 0.5,
              height: MediaQuery.of(context).size.height * 0.04,
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 10.0 * width_ratio),
                  child: AutoSizeText(
                    start_text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0 * height_ratio,
                      //color: th_colour
                    ),
                  ))),
          Container(
              width: MediaQuery.of(context).size.width * 0.9 * 0.5,
              height: MediaQuery.of(context).size.height * 0.04,
              alignment: Alignment.centerRight,
              child: Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: AutoSizeText(
                    end_text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0 * height_ratio,
                      //color: th_colour
                    ),
                  ))),
        ])
      ],
    );
  }

  Widget _getNpsItemSingleLandscape(int position) {
    return InkWell(
        onTap: () {
          setState(() {
            app_config.questions[page].questions[0].answer =
                position.toString();
            page++;
          });
        },
        child: Container(
            height: MediaQuery.of(context).size.height * 0.11,
            //color: Colors.lime,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.08,
              //margin: EdgeInsets.only(left: 5,right: 5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(int.parse(colors_nps_master[position]))),
              child: Center(
                child: AutoSizeText(
                  position.toString(),
                  style: TextStyle(
                      fontSize: 32 * height_ratio,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )));
  }

  ///
  /// Personal Questions Landscape
  Widget _personalDetailsQuestionsLandscape() {

      setState(() {
      show_bottom_button = false;
    });
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _personalDetailsQuestionsRow1Landscape(),
        _personalDetailsQuestionsRow2Landscape()
      ],
    ));
  }

  Widget _personalDetailsQuestionsRow1Landscape() {
    if (profile_name || profile_email || profile_address) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.9 * 0.5,
          child: Container(
              margin: EdgeInsets.only(right: 10.0),
              child: Column(
                children: <Widget>[
                  _personalDetailsQuestionsRow1NameLandscape(),
                  _personalDetailsQuestionsRow1PhoneLandscape(),
                  _personalDetailsQuestionsRow1EmailLandscape(),
                ],
              )));
    } else {
      return Container();
    }
  }

  Widget _personalDetailsQuestionsRow1NameLandscape() {
    if (profile_name) {
      return Container(
          //height: MediaQuery.of(context).size.height*0.2,

          child: Material(
        elevation: 1.0,
        //shadowColor: Colors.grey[200],
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        child: TextFormField(
          style: TextStyle(fontSize: 15.0 * width_ratio, color: Colors.black),
          controller: _name_controller,
          decoration: InputDecoration(
              labelText: profile_name_text,
              labelStyle: TextStyle(
                  color: Colors.grey[400], fontSize: 13.0 * width_ratio),
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.4),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0 * width_ratio),
              )),
          validator: (value) {
            /*if(value.isEmpty){
                                                                                                                                      return 'Fill Phone';
                                                                                                                                  }
                                                                                                                  return null;*/
          },
        ),
      ));
    } else {
      return Container();
    }
  }

  Widget _personalDetailsQuestionsRow1PhoneLandscape() {
    if (profile_phone) {
      return Container(
          //height: MediaQuery.of(context).size.height*0.2,
          margin: EdgeInsets.only(top: 20.0 * height_ratio),
          child: Material(
            elevation: 1.0,
            //shadowColor: Colors.grey[200],
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            child: TextFormField(
              style:
                  TextStyle(fontSize: 13.0 * width_ratio, color: Colors.black),
              controller: _phone_controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                BlacklistingTextInputFormatter(new RegExp('[\\-|\\ ]'))
              ],
              decoration: InputDecoration(
                  labelText: profile_phone_text,
                  labelStyle: TextStyle(
                      color: Colors.grey[400], fontSize: 13.0 * width_ratio),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0 * width_ratio),
                  )),
              validator: (value) {
                /*if(value.isEmpty){
                                                                                                                                      return 'Fill Phone';
                                                                                                                                  }
                                                                                                                  return null;*/
              },
            ),
          ));
    } else {
      return Container();
    }
  }

  Widget _personalDetailsQuestionsRow1EmailLandscape() {
    if (profile_email) {
      return Container(
          //height: MediaQuery.of(context).size.height*0.2,
          margin: EdgeInsets.only(top: 20.0 * height_ratio),
          child: Material(
            elevation: 1.0,
            //shadowColor: Colors.grey[200],
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
              child: Form(
          key: formKey,
            child: TextFormField(

              keyboardType: TextInputType.emailAddress,
              style:
                  TextStyle(fontSize: 13.0 * width_ratio, color: Colors.black),
              controller: _email_controller,
              decoration: InputDecoration(
                  labelText: profile_email_text,
                  labelStyle: TextStyle(
                      color: Colors.grey[400], fontSize: 13.0 * width_ratio),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0 * width_ratio),
                  )),
                 
      
          
              
            ),
              )
          ));
    } else {
      return Container();
    }
  }

  Widget _personalDetailsQuestionsRow2Landscape() {
    if (profile_address || profile_comment) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.9 * 0.5,
          //color: Colors.lightGreen,
          child: Column(
            children: <Widget>[
              _personalDetailsQuestionsRow2AddressLandscape(),
              _personalDetailsQuestionsRow2CommentLandscape()
            ],
          ));
    } else {
      return Container();
    }
  }

  Widget _personalDetailsQuestionsRow2AddressLandscape() {
    if (profile_address) {
      return Container(
          margin: EdgeInsets.only(left: 10.0 * width_ratio),
          height: MediaQuery.of(context).size.height * 0.12,
          child: Material(
            elevation: 1.0,
            //shadowColor: Colors.grey[200],
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            child: TextFormField(
              style:
                  TextStyle(fontSize: 13.0 * width_ratio, color: Colors.black),
              controller: _address_controller,
              maxLines: 5,
              decoration: InputDecoration(
                  labelText: profile_address_text,
                  labelStyle: TextStyle(
                      color: Colors.grey[400], fontSize: 13.0 * width_ratio),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0 * width_ratio),
                  )),
              
            ),
          ));
    } else {
      return Container();
    }
  }

  Widget _personalDetailsQuestionsRow2CommentLandscape() {
    if (profile_comment) {
      return Container(
          margin:
              EdgeInsets.only(left: 10.0 * width_ratio, top: 10 * height_ratio),
          height: MediaQuery.of(context).size.height * 0.12,
          child: Material(
            elevation: 1.0,
            //shadowColor: Colors.grey[200],
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            child: TextFormField(
              style:
                  TextStyle(fontSize: 13.0 * width_ratio, color: Colors.black),
              controller: _comment_controller,
              maxLines: 5,
              decoration: InputDecoration(
                  labelText: profile_comment_text,
                  labelStyle: TextStyle(
                      color: Colors.grey[400], fontSize: 13.0 * width_ratio),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0 * width_ratio),
                  )),
         
            ),
          ));
    } else {
      return Container();
    }
  }

  Widget _personalDetailsButtonLandscape() {
    return Container(
       margin: EdgeInsets.only(top: 30.0 * height_ratio),
      width: MediaQuery.of(context).size.width * 0.28,
      height: MediaQuery.of(context).size.height * 0.08,
   //margin: EdgeInsets.only(top: 30.0 * height_ratio),
     // width: MediaQuery.of(context).size.width * 0.28,
      //height: MediaQuery.of(context).size.height * 0.1,
      //color: Colors.purple,
      child: InkWell(
          onTap: () {
            if(_valid_email == false){
                   showToast("Invalid Email");
            }else{
               print("iouoiuoiuoiuoiui");
              var i = 0;
          for (var pro in app_config.questions[page].questions) {
            if (pro.fieldId == "1") {
              app_config.questions[page].questions[i].answer =
                  _name_controller.text;
              _name_controller.text = "";
            } else if (pro.fieldId == "3") {
              app_config.questions[page].questions[i].answer =
                  _email_controller.text;
              _email_controller.text = "";
            } else if (pro.fieldId == "2") {
              app_config.questions[page].questions[i].answer =
                  _phone_controller.text;
              _phone_controller.text = "";
            } else if (pro.fieldId == "4") {
              app_config.questions[page].questions[i].answer =
                  _address_controller.text;
              _address_controller.text = "";
            } else if (pro.fieldId == "5") {
              app_config.questions[page].questions[i].answer =
                  _comment_controller.text;
              _comment_controller.text = "";
            }
            i++;
          }
          
          setState(() {
            page++;
          });
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.11,
            height: MediaQuery.of(context).size.height * 0.55,
            alignment: Alignment.center,
            //margin: EdgeInsets.only(top: 20.0*height_ratio,bottom: 20.0*height_ratio),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5.0,
                    color: Color(0xff0F6F1E).withOpacity(0.1),
                    offset: Offset(6.0, 7.0),
                  ),
                ],
                color: Color(0xff0F6F1E),
                borderRadius: BorderRadius.circular(15.0 * height_ratio)),

            child: Text(
              "NEXT",
              style: TextStyle(fontSize: 12 * width_ratio, color: Colors.white),
            ),
          )));
      
      
      
      
      
      
      

  }

  ///
  ///Questions Section
  Widget _questionsSectionMainLandscape() {
    setState(() {
      show_bottom_button = true;
    });
    return Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
        height: MediaQuery.of(context).size.height * 0.6,
        //color: Colors.lime,
        alignment: Alignment.center,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _questionsHeadLandscape(),
                  _questionsBodyLandscape()
                ])));
  }

  Widget _questionsHeadLandscape() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9 * 0.5,
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9 * 0.5,
            height: MediaQuery.of(context).size.height * 0.06,
            child: _questionHeadTitlesLandscape(),
          )
        ],
      ),
    );
  }

  Widget _questionHeadTitlesLandscape() {
    var image_text1 =
        app_config.questions[page].questions[0].rateText1Language1;
    var image_text2 =
        app_config.questions[page].questions[0].rateText2Language1;
    var image_text3 =
        app_config.questions[page].questions[0].rateText3Language1;
    var image_text4 =
        app_config.questions[page].questions[0].rateText4Language1;
    var image_text5 =
        app_config.questions[page].questions[0].rateText5Language1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      image_text1 = app_config.questions[page].questions[0].rateText1Language2;
      image_text2 = app_config.questions[page].questions[0].rateText2Language2;
      image_text3 = app_config.questions[page].questions[0].rateText3Language2;
      image_text4 = app_config.questions[page].questions[0].rateText4Language2;
      image_text5 = app_config.questions[page].questions[0].rateText5Language2;
      //print(app_config.questions[page].questions.length);
    }
    if (app_config.questions[page].questions[0].smileyCount == "5") {
      return Row(
        children: <Widget>[
          _questionHeadTitleSingleLandscape(image_text1),
          _questionHeadTitleSingleLandscape(image_text2),
          _questionHeadTitleSingleLandscape(image_text3),
          _questionHeadTitleSingleLandscape(image_text4),
          _questionHeadTitleSingleLandscape(image_text5),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(
                  left: 20.0 * width_ratio, right: 20.0 * width_ratio),
              child: _questionHeadTitleSingleLandscape(image_text1)),
          Container(
            margin: EdgeInsets.only(
                left: 20.0 * width_ratio, right: 20.0 * width_ratio),
            child: _questionHeadTitleSingleLandscape(image_text2),
          ),
          Container(
              margin: EdgeInsets.only(
                  left: 20.0 * width_ratio, right: 20.0 * width_ratio),
              child: _questionHeadTitleSingleLandscape(image_text3))
        ],
      );
    }
  }

  Widget _questionHeadTitleSingleLandscape(String text) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9 * 0.5 / 5,
      alignment: Alignment.center,
      //color: Colors.blue,
      child: Text(
        text,
        style: TextStyle(fontSize: 12 * width_ratio),
        textAlign: TextAlign.center,
      ),
    );
  }

  /*Widget _questionsBody1(){
          return Container(
                             alignment: Alignment.center,
                              child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                    _questionItemRow(0),
                                                    _questionItemRow(1),
                                                    _questionItemRow(2),
                                                    _questionItemRow(3),
                                                    _questionItemRow(4)
                                              ]
                                        )
                      );   
      }*/
  Widget _questionsBodyLandscape() {
    return Expanded(
        child: ListView.builder(
            itemCount: app_config.questions[page].questions.length,
            itemBuilder: (BuildContext context, int position) {
              return _questionItemRowLandscape(position);
            }));
  }

  Widget _questionItemRowLandscape(int position) {
    var bg_colour = Colors.white;
    if (position % 2 == 0) {
      bg_colour = Colors.grey[100];
    }
    var question =
        app_config.questions[page].questions[position].questionLanguage1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      question =
          app_config.questions[page].questions[position].questionLanguage2;
    }

    return Container(
      padding: EdgeInsets.only(left: 0),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.11,
      color: bg_colour,
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9 * 0.5,
            height: MediaQuery.of(context).size.height * 0.09,
            padding: EdgeInsets.only(left: 7),
            alignment: Alignment.centerLeft,
            child: Text(
              question,
              style: TextStyle(fontSize: 14 * width_ratio),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9 * 0.5,
            height: MediaQuery.of(context).size.height * 0.09,
            child: _questionItemRowSmileysLandscape(position),
          )
        ],
      ),
    );
  }

  Widget _questionItemRowSmileysLandscape(int position) {
    if (app_config.questions[page].questions[position].smileyCount == "5") {
      return _questionItemRowSmileysFiveLandscape(position);
    } else {
      return _questionItemRowSmileysThreeLandscape(position);
    }
  }

  Widget _questionItemRowSmileysThreeLandscape(int position) {
    return Row(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(
                left: 20.0 * width_ratio, right: 20.0 * width_ratio),
            child: _questionItemRowSmileysSingleLandscape(position, 1)),
        Container(
            margin: EdgeInsets.only(
                left: 20.0 * width_ratio, right: 20.0 * width_ratio),
            child: _questionItemRowSmileysSingleLandscape(position, 2)),
        Container(
            margin: EdgeInsets.only(
                left: 20.0 * width_ratio, right: 20.0 * width_ratio),
            child: _questionItemRowSmileysSingleLandscape(position, 3)),
      ],
    );
  }

  Widget _questionItemRowSmileysFiveLandscape(int position) {
    return Row(
      children: <Widget>[
        _questionItemRowSmileysSingleLandscape(position, 1),
        _questionItemRowSmileysSingleLandscape(position, 2),
        _questionItemRowSmileysSingleLandscape(position, 3),
        _questionItemRowSmileysSingleLandscape(position, 4),
        _questionItemRowSmileysSingleLandscape(position, 5)
      ],
    );
  }

  Widget _questionItemRowSmileysSingleLandscape(
      int position, int image_position) {
    var cur_image = app_config.questions[page].questions[position].imageUrl1;
    if (image_position == 1) {
      cur_image = app_config.questions[page].questions[position].imageUrl1;
    } else if (image_position == 2) {
      cur_image = app_config.questions[page].questions[position].imageUrl2;
    } else if (image_position == 3) {
      cur_image = app_config.questions[page].questions[position].imageUrl3;
    } else if (image_position == 4) {
      cur_image = app_config.questions[page].questions[position].imageUrl4;
    } else if (image_position == 5) {
      cur_image = app_config.questions[page].questions[position].imageUrl5;
    }
    var image_opacity = 0.5;
    if (app_config.questions[page].questions[position].answer ==
        image_position.toString()) {
      image_opacity = 0;
    }
    return Container(
        width: MediaQuery.of(context).size.width * 0.9 * 0.5 / 5,
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            setState(() {
              app_config.questions[page].questions[position].answer =
                  image_position.toString();
            });
          },
          /*child: Image.network(
                                                                          cur_image,
                                                                          scale: 1.2,
                                                                        )*/
          child: Container(
           
              width: MediaQuery.of(context).size.width * 0.9 * 0.45 / 5,
              height: MediaQuery.of(context).size.height * 0.07,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(cur_image), fit: BoxFit.contain)),
              //child: _questionItemRowSmileysSingleTickLandscape(position, image_position)
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9 * 0.45 / 5,
                height: MediaQuery.of(context).size.height * 0.07,
                color: Colors.white.withOpacity(image_opacity),
              )),
        ));
  }

  Widget _questionItemRowSmileysSingleTickLandscape(
      int position, int image_position) {
    if (app_config.questions[page].questions[position].answer == image_position.toString()) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.9 * 0.45 * 0.3 / 5,
          height: MediaQuery.of(context).size.height * 0.03,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/tick.png"),
                  fit: BoxFit.contain)));
    } else {
      return Container();
    }
  }

  ///
  ///Over all Expierience
  Widget _reasoningSectionMain() {
    var smily_question = app_config.questions[page].questions[0].questionLanguage1;
    if (app_config.questions[page].multipleLanguage == 1 && language_selected == 1) {
        smily_question = app_config.questions[page].questions[0].questionLanguage2;
      }
    var reson_question = app_config.reason_question_language1;
    if (app_config.questions[page].multipleLanguage == 1 && language_selected == 1) {
        reson_question = app_config.reason_question_language2;
      }
    //print(smily_question);
    //print(reson_question);  
    setState(() {
      show_bottom_button = true;
    });
    return Container(
        margin: EdgeInsets.only(
            top: 20.0 * height_ratio, bottom: 20.0 * height_ratio),
        height: MediaQuery.of(context).size.height * 0.6,
        alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 30.0 * height_ratio),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Center(
                  child: AutoSizeText(
                    smily_question,
                    style: TextStyle(fontSize: 25 * height_ratio),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                  //color: Colors.red,
                  child: _reasoningSectionSmily()),
              Container(
                margin: EdgeInsets.only(
                    bottom: 25.0 * height_ratio, top: 35 * height_ratio),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Center(
                  child: AutoSizeText(
                    reson_question,
                    style: TextStyle(fontSize: 22 * height_ratio),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.65,
                  alignment: Alignment.topCenter,
                  child: _reasoningSectionReasoning()),
            ]));
  }

  Widget _reasoningSectionReasoning() {
    /*return GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 3,
            
            // Generate 100 widgets that display their index in the List.
            children: List.generate(5, (index) {
                    return Container(
                                margin: EdgeInsets.all(10),
                                height: MediaQuery.of(context).size.width*0.01,
                                color: Colors.red,
                            );
            }),
          );*/
    return new GridView.builder(
        itemCount: app_config.reasons.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3.5),
        ),
        itemBuilder: (BuildContext context, int index) {
          var _border_color = Colors.black;
          var _bg_colour = Colors.white;
          var _text_colour = Colors.black;
          if (app_config.reasons[index].selected) {
            _border_color = Colors.white;
            _bg_colour = Colors.black;
            _text_colour = Colors.white;
          }
          var reason_text = app_config.reasons[index].answerLanguage1 + " + ";
          if (app_config.questions[page].multipleLanguage == 1 &&
              language_selected == 1) {
            reason_text = app_config.reasons[index].answerLanguage2 + " + ";
          }
          return InkWell(
              onTap: () {
                setState(() {
                  app_config.reasons[index].selected =
                      !app_config.reasons[index].selected;
                });
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.01,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _bg_colour,
                  border: new Border.all(
                    width: 0.8,
                    color: _border_color,
                  ),
                  borderRadius:
                      BorderRadius.all(Radius.circular(30.0 * width_ratio)),
                ),
                child: Text(
                  reason_text,
                  style: TextStyle(
                      fontSize: 18 * width_ratio, color: _text_colour),
                ),
              ));
        });
  }

  Widget _reasoningSectionSmily() {
    if (app_config.questions[page].questions[0].smileyCount == "5") {
      return _reasoningSectionSmilyFive();
    } else {
      return _reasoningSectionSmilyThree();
    }
  }

  Widget _reasoningSectionSmilyThree() {
    var image1 = app_config.questions[page].questions[0].imageUrl1;
    var image2 = app_config.questions[page].questions[0].imageUrl2;
    var image3 = app_config.questions[page].questions[0].imageUrl3;
    var image_text1 =
        app_config.questions[page].questions[0].rateText1Language1;
    var image_text2 =
        app_config.questions[page].questions[0].rateText2Language1;
    var image_text3 =
        app_config.questions[page].questions[0].rateText3Language1;
    //print(image_text3);
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      image_text1 = app_config.questions[page].questions[0].rateText1Language2;
      image_text2 = app_config.questions[page].questions[0].rateText2Language2;
      image_text3 = app_config.questions[page].questions[0].rateText3Language2;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _reasoningSectionSmilyRow(image_text1, image1, "1", 3),
        _reasoningSectionSmilyRow(image_text2, image2, "2", 3),
        _reasoningSectionSmilyRow(image_text3, image3, "3", 3)
      ],
    );
  }

  Widget _reasoningSectionSmilyRow(
      String text, String image, String position, int smily_count) {
    if (smily_count == 5) {}
    var image_opacity = 0.6;
    if (app_config.questions[page].questions[0].answer == position.toString()) {
      image_opacity = 0;
    }
    return InkWell(
      onTap: () {
        setState(() {
          //page++;
          app_config.questions[page].questions[0].answer = position;
        });
      },
      child: Container(
        //color: Colors.blue,
        //margin: EdgeInsets.only(left: margin_row*width_ratio,right:margin_row*width_ratio),
        height: MediaQuery.of(context).size.height * 0.16,

        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.15,
                //color: Colors.blue,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.contain)),
                child:
                    Container(color: Colors.white.withOpacity(image_opacity)),
              ),
              Container(
                  //color: Colors.purple,
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(
                      child: AutoSizeText(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0 * height_ratio,
                      //color: th_colour
                    ),
                  )))
            ]),
      ),
    );
  }

  Widget _reasoningSectionSmilyFive() {
    var image1 = app_config.questions[page].questions[0].imageUrl1;
    var image2 = app_config.questions[page].questions[0].imageUrl2;
    var image3 = app_config.questions[page].questions[0].imageUrl3;
    var image4 = app_config.questions[page].questions[0].imageUrl4;
    var image5 = app_config.questions[page].questions[0].imageUrl5;
    var image_text1 =
        app_config.questions[page].questions[0].rateText1Language1;
    var image_text2 =
        app_config.questions[page].questions[0].rateText2Language1;
    var image_text3 =
        app_config.questions[page].questions[0].rateText3Language1;
    var image_text4 =
        app_config.questions[page].questions[0].rateText4Language1;
    var image_text5 =
        app_config.questions[page].questions[0].rateText5Language1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      image_text1 = app_config.questions[page].questions[0].rateText1Language2;
      image_text2 = app_config.questions[page].questions[0].rateText2Language2;
      image_text3 = app_config.questions[page].questions[0].rateText3Language2;
      image_text4 = app_config.questions[page].questions[0].rateText4Language2;
      image_text5 = app_config.questions[page].questions[0].rateText5Language2;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _reasoningSectionSmilyRow(image_text1, image1, "1", 5),
        _reasoningSectionSmilyRow(image_text2, image2, "2", 5),
        _reasoningSectionSmilyRow(image_text3, image3, "3", 5),
        _reasoningSectionSmilyRow(image_text4, image4, "4", 5),
        _reasoningSectionSmilyRow(image_text5, image5, "5", 5)
      ],
    );
  }

  ///Reasoning Landscape
  Widget _reasoningSectionMainLandscape() {
    var smily_question =
        app_config.questions[page].questions[0].questionLanguage1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      smily_question =
          app_config.questions[page].questions[0].questionLanguage2;
    }
    var reson_question = app_config.reason_question_language1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      reson_question = app_config.reason_question_language2;
    }
    setState(() {
      show_bottom_button = true;
    });
    return Container(
        margin: EdgeInsets.only(
            top: 20.0 * height_ratio, bottom: 20.0 * height_ratio),
        height: MediaQuery.of(context).size.height * 0.65,
        alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 50.0 * height_ratio),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Center(
                  child: AutoSizeText(
                    smily_question,
                    style: TextStyle(fontSize: 30 * height_ratio),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                  //color: Colors.red,
                  child: _reasoningSectionSmilyLandscape()),
              Container(
                margin: EdgeInsets.only(
                    bottom: 30.0 * height_ratio, top: 50 * height_ratio),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Center(
                  child: AutoSizeText(
                    reson_question,
                    style: TextStyle(fontSize: 38 * height_ratio),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.75,
                  alignment: Alignment.topCenter,
                  child: _reasoningSectionReasoningLandscape()),
            ]));
  }

  Widget _reasoningSectionSmilyLandscape() {
    if (app_config.questions[page].questions[0].smileyCount == "5") {
      return _reasoningSectionSmilyFiveLandscape();
    } else {
      return _reasoningSectionSmilyThreeLandscape();
    }
  }

  Widget _reasoningSectionSmilyThreeLandscape() {
    var image1 = app_config.questions[page].questions[0].imageUrl1;
    var image2 = app_config.questions[page].questions[0].imageUrl2;
    var image3 = app_config.questions[page].questions[0].imageUrl3;
    var image_text1 =
        app_config.questions[page].questions[0].rateText1Language1;
    var image_text2 =
        app_config.questions[page].questions[0].rateText2Language1;
    var image_text3 =
        app_config.questions[page].questions[0].rateText3Language1;
    //print(image_text3);
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      image_text1 = app_config.questions[page].questions[0].rateText1Language2;
      image_text2 = app_config.questions[page].questions[0].rateText2Language2;
      image_text3 = app_config.questions[page].questions[0].rateText3Language2;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _reasoningSectionSmilyRowLandscape(image_text1, image1, "1", 3),
        _reasoningSectionSmilyRowLandscape(image_text2, image2, "2", 3),
        _reasoningSectionSmilyRowLandscape(image_text3, image3, "3", 3)
      ],
    );
  }

  Widget _reasoningSectionSmilyRowLandscape(
      String text, String image, String position, int smily_count) {
    if (smily_count == 5) {}
    var image_opacity = 0.6;
    if (app_config.questions[page].questions[0].answer == position.toString()) {
      image_opacity = 0;
    }
    return InkWell(
      onTap: () {
        //app_config.questions[page].questions[0].answer = position;
        setState(() {
          //page++;
          app_config.questions[page].questions[0].answer = position;
        });
      },
      child: Container(
        //color: Colors.blue,
        //margin: EdgeInsets.only(left: margin_row*width_ratio,right:margin_row*width_ratio),
        height: MediaQuery.of(context).size.height * 0.16,

        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.11,
                width: MediaQuery.of(context).size.width * 0.16,
                child:
                    Container(color: Colors.white.withOpacity(image_opacity)),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.contain)),
              ),
              Container(
                  //color: Colors.purple,
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(
                      child: AutoSizeText(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0 * height_ratio,
                      //color: th_colour
                    ),
                  ))),
            ]),
      ),
    );
  }

  Widget _reasoningSectionSmilyFiveLandscape() {
    var image1 = app_config.questions[page].questions[0].imageUrl1;
    var image2 = app_config.questions[page].questions[0].imageUrl2;
    var image3 = app_config.questions[page].questions[0].imageUrl3;
    var image4 = app_config.questions[page].questions[0].imageUrl4;
    var image5 = app_config.questions[page].questions[0].imageUrl5;
    var image_text1 =
        app_config.questions[page].questions[0].rateText1Language1;
    var image_text2 =
        app_config.questions[page].questions[0].rateText2Language1;
    var image_text3 =
        app_config.questions[page].questions[0].rateText3Language1;
    var image_text4 =
        app_config.questions[page].questions[0].rateText4Language1;
    var image_text5 =
        app_config.questions[page].questions[0].rateText5Language1;
    if (app_config.questions[page].multipleLanguage == 1 &&
        language_selected == 1) {
      image_text1 = app_config.questions[page].questions[0].rateText1Language2;
      image_text2 = app_config.questions[page].questions[0].rateText2Language2;
      image_text3 = app_config.questions[page].questions[0].rateText3Language2;
      image_text4 = app_config.questions[page].questions[0].rateText4Language2;
      image_text5 = app_config.questions[page].questions[0].rateText5Language2;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _reasoningSectionSmilyRowLandscape(image_text1, image1, "1", 5),
        _reasoningSectionSmilyRowLandscape(image_text2, image2, "2", 5),
        _reasoningSectionSmilyRowLandscape(image_text3, image3, "3", 5),
        _reasoningSectionSmilyRowLandscape(image_text4, image4, "4", 5),
        _reasoningSectionSmilyRowLandscape(image_text5, image5, "5", 5)
      ],
    );
  }

  Widget _reasoningSectionReasoningLandscape() {
    /*return GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 3,
            
            // Generate 100 widgets that display their index in the List.
            children: List.generate(5, (index) {
                    return Container(
                                margin: EdgeInsets.all(10),
                                height: MediaQuery.of(context).size.width*0.01,
                                color: Colors.red,
                            );
            }),
          );*/
    return new GridView.builder(
        itemCount: app_config.reasons.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3),
        ),
        itemBuilder: (BuildContext context, int index) {
          var _border_color = Colors.black;
          var _bg_colour = Colors.white;
          var _text_colour = Colors.black;
          if (app_config.reasons[index].selected) {
            _border_color = Colors.white;
            _bg_colour = Colors.black;
            _text_colour = Colors.white;
          }
          var reason_text = app_config.reasons[index].answerLanguage1 + " + ";
          if (app_config.questions[page].multipleLanguage == 1 &&
              language_selected == 1) {
            reason_text = app_config.reasons[index].answerLanguage2 + " + ";
          }
          return InkWell(
              onTap: () {
                setState(() {
                  app_config.reasons[index].selected =
                      !app_config.reasons[index].selected;
                });
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.01,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _bg_colour,
                  border: new Border.all(
                    width: 0.8,
                    color: _border_color,
                  ),
                  borderRadius:
                      BorderRadius.all(Radius.circular(30.0 * width_ratio)),
                ),
                child: Text(
                  reason_text,
                  style: TextStyle(
                      fontSize: 18 * width_ratio, color: _text_colour),
                ),
              ));
        });
  }

  ////
  ///
  _getHomeData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        MainModel model = MainModel();
        await model.getHome();
        setState(() {
          page = 0;
          start = 1;
          //print(app_config.questions.length);
        });
      }
    } on SocketException catch (_) {}
  }

  ///
  ///
  _sendAnswer(String json_str) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //print(json_str);
        MainModel model = MainModel();
        var res = await model.sendAnswer(json_str);
        if (res) {
          setState(() {
            //page=0;
            //start=1;

            success_page = 1;
            //print(app_config.questions.length);
          });

          Future.delayed(const Duration(seconds: 4), () {
            // Here you can write your code
            setState(() {
              app_config.questions = app_config.questions_org;
              success_page = 0;
              start = 1;
              page = 0;
            });
          });
        }
      }
    } on SocketException catch (_) {}
  }

  ///
  ///
  ///

  Future _logoutConfirm(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are You sure'),
          content: const Text('Are You sure to logout?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('OK'),
              onPressed: () async {
                await _logoutUser();
              },
            )
          ],
        );
      },
    );
  }

  _logoutUser() async {
    MainModel model = MainModel();
    await model.setAccessTokken("");
    app_config.userTokken = "";
    showToast("Logout succesfully");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  ///show toast
  void showToast(String msg, {int duration, int gravity}) {
    //Toast.show(msg, context, duration: duration, gravity: gravity);
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Color(0xffBF1D1D).withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  bool _isEmailValid(String value) {
  String pattern =
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
  RegExp regExp = new RegExp(pattern);

  return regExp.hasMatch(value);
}

  ///

}
