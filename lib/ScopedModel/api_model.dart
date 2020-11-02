import 'package:scoped_model/scoped_model.dart';
import 'package:feedback/ScopedModel/main_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:feedback/Utitlity/app_config.dart' as app_config;
import 'package:feedback/Utitlity/constants.dart';
import 'package:feedback/Models/questioneir_model.dart';
import 'package:feedback/Models/all_questions_model.dart';
import 'package:feedback/Models/reason_items_model.dart';

mixin ApiModel on Model {
  bool isLoading = false;
 
 /* Make Login */
  Future<bool> checkId(String id) async {
    bool result = false;
    MainModel model = MainModel();
    isLoading = true;

    await http
        .post(BASE_URL_API + URL_CHECK_ID,
            headers: {"Content-Type": "application/json"},
            body: json.encode({"WebLinkKey": id}))
        .then((onValue) async{
      //print(onValue.body.toString());
      final Map<String, dynamic> arr = json.decode(onValue.body);
      if (arr["IsSuccess"].toString().toLowerCase() == "true") {
        //model.setAccessTokken(arr["Token"]);
        //app_config.userTokken = arr["Token"];
        //print(app_config.userTokken);
        //print(model.getAccessTokken());
        await model.setWebUrl(arr["WebsiteLink"]);
        await model.setApiUrl(arr["APIWebLink"]);
        app_config.web_url=arr["WebsiteLink"];
        app_config.api_url=arr["APIWebLink"];
       
        result = true;
      }
    });
    isLoading = false;
    return result;
  }
 
  /* Make Login */
  Future<bool> makeLogin(String username, String password) async {
    bool result = false;
    MainModel model = MainModel();
    isLoading = true;

    await http
        .post(BASE_URL_API + URL_LOGIN,
            headers: {"Content-Type": "application/json",
                      TOKKENVALID_KEY : "Token "+LOGIN_TOKKEN_VALUE
                      },
            body: json.encode({"login_id": username, "password": password}))
        .then((onValue) {
      print(onValue.body.toString());
      final Map<String, dynamic> arr = json.decode(onValue.body);
      if (arr["status"].toString().toLowerCase() == "1") {
        model.setAccessTokken(arr["tokken"]);
        app_config.userTokken = arr["tokken"];
        //print(app_config.userTokken);
        //print(model.getAccessTokken());
        result = true;
      }
    });
    isLoading = false;
    return result;
  }

  /* Make Logout */
  Future<bool> makeLogout() async {
    bool result = false;
    MainModel model = MainModel();
    isLoading = true;
    model.setAccessTokken("");
    app_config.userTokken = "";
    //print(app_config.userTokken);
    //print(model.getAccessTokken());
    result = true;
  }

  /* Get Home Data */
  Future<bool> getHome() async {
    //print(app_config.userTokken);
    bool result = false;
    app_config.questions = List<QuestioneirModel>();
    List<String> serial_numbers = List<String>();
    app_config.reasons = List<ReasonItemsModel>();
    MainModel model = MainModel();
 
    await http.get(BASE_URL_API + URL_GET_QUESTIONS, headers: {
      "Content-Type": "application/json",
      AUTHORIZATION_TOKKEN_KEY: "Bearer " + app_config.userTokken,
      TOKKENVALID_KEY : "Token "+PROFILE_TOKKEN_VALUE
    }).then((onValue) {
      //print(onValue.body.toString());
      //var arr=jsonDecode(onValue.body);
      final Map<String, dynamic> arr = json.decode(onValue.body);
      if (arr["status"].toString().toLowerCase() == "1") {
        result = true;
        app_config.load_home_data = false;
        //Base Urls
        app_config.web_url = arr["smily_base_url"];
        app_config.logo_url_image_baseurl = arr["user_base_url"];
        app_config.thanks_url_image_baseurl = arr["thanksscreen_base_url"];
        ///
        
        //company details
        Map<String, dynamic> com = arr["company_details"];
        app_config.company_name = com['name'];
        app_config.company_email = "";
        app_config.company_website = "";
        app_config.company_fax = "";
        app_config.company_logo = com['logo'];
        app_config.company_phone = "";
        app_config.company_phone2 = "";
        app_config.language1 = com['language_name1'];
        app_config.language2 = com['language_name2'];
        app_config.company_address = "";
        if (com['logo'] != "" && com['logo'] != null) {
          app_config.company_logo = app_config.logo_url_image_baseurl + com['logo'];
          app_config.company_logo_exist = true;
        } else {
          app_config.company_logo_exist = false;
        }
        if (com["has_multi_language"].toString().toLowerCase() == "true") {
          app_config.has_multi_language = true;
        } else {
          app_config.has_multi_language = false;
        }
        if (com["thank_you_image"] != "" && com["thank_you_image"] != null) {
          app_config.thank_you_image_exist = true;
          app_config.thank_you_image = app_config.thanks_url_image_baseurl + com["thank_you_image"];
          
        } else {
          app_config.thank_you_image_exist = false;
        }
        if (com["thank_you_text"] != "" && com["thank_you_text"] != null) {
            app_config.thank_you_text = com["thank_you_text"];

        } else {
            app_config.thank_you_text = "";
        }
        //
        
        Iterable question_list = arr["questions"];
        for (var que in question_list) {
          var cur = AllQuestionsModel.fromJson(que);
          if (serial_numbers.contains(cur.serial)) {
                if (que["QuestionTypeID"] == 3 || que["QuestionTypeID"] == 4) {
                  
                        //print(que["QuestionTypeID"]);
                  //app_config.nps=NpsModel.fromJson(que);
                  //Smily question multiple -questionneire
                  for (int i = 0; i < app_config.questions.length; i++) {
                    if (app_config.questions[i].screen_number == cur.serial) {
                      app_config.questions[i].questions.add(cur);
                      break;
                    }
                  }
                } 
          } 
          else {
                    if (que["QuestionTypeID"] == 5) {
                        app_config.reason_question_language1 = que["StartL1Text"];
                        app_config.reason_question_language2 = que["StartL2Text"];
                        
                      }
                  serial_numbers.add(cur.serial);
                  var questioneire_questions = List<AllQuestionsModel>();
                  questioneire_questions.add(cur);
                  var cur_question = QuestioneirModel(
                                      id: cur.id,
                                      screen_number: cur.serial,
                                      type: cur.type,
                                      multipleLanguage: cur.multipleLanguage,
                                      questions: questioneire_questions);
                  app_config.questions.add(cur_question);
                  /*if(que["QuestionTypeID"]==1){
                                                                //Smily question single - Smily

                                                            }
                                                          else if(que["QuestionTypeID"]==2){
                                                                //app_config.nps=NpsModel.fromJson(que);
                                                                //nps
                                                            } 
                                                          else if(que["QuestionTypeID"]==3){
                                                                //app_config.nps=NpsModel.fromJson(que);
                                                                //Smily question multiple -questionneire
                                                            }    
                                                          else if(que["QuestionTypeID"]==4){
                                                                //app_config.personal_questions.add(PersonalQuestionModel.fromJson(que));
                                                                ///Personal Questions
                                                            }*/
                }
        }
        app_config.questions_org = app_config.questions;
        Iterable reason_list = arr["reason_answers"];
        app_config.reasons =
            reason_list.map((data) => ReasonItemsModel.fromJson(data)).toList();
        //app_config.reason_question_language1="Reason For The Rating ?";
        //app_config.reason_question_language2="Reason For the Rating ?";
        notifyListeners();
      } else {}
    });
    return result;
  }

  /* Get Company Data */
  Future<bool> getCompany() async {
    bool result = false;

    MainModel model = MainModel();

    await http.get(app_config.api_url + URL_GET_QUESTIONS, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + app_config.userTokken
    }).then((onValue) {
      //print(onValue.body.toString());
      //var arr=jsonDecode(onValue.body);
      final Map<String, dynamic> arr = json.decode(onValue.body);

      if (arr["IsSuccess"].toString().toLowerCase() == "true") {
        app_config.company_name = arr['Name'];
        app_config.company_email = arr['EmailAddress'];
        app_config.company_website = arr['Website'];
        app_config.company_fax = arr['Fax'];
        app_config.company_phone = arr['PhoneNo'];
        app_config.company_phone2 = arr['PhoneNo2'];
        app_config.language1 = arr['LanguageName1'];
        app_config.language2 = arr['LanguageName2'];
        app_config.company_address = arr['Address'];
        if (arr['Logo'] != "" && arr['Logo'] != null) {
          app_config.company_logo = app_config.web_url + arr['Logo'];
          app_config.company_logo_exist = true;
        } else {
          app_config.company_logo_exist = false;
        }

        result = true;
      }
    });
    return result;
  }

  /* Make Login */
  Future<bool> sendAnswer(String json_str) async {
    bool result = false;
    MainModel model = MainModel();
    isLoading = true;
    await http
        .post(BASE_URL_API + URL_POST_ANSWERS,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer " + app_config.userTokken,
              TOKKENVALID_KEY : "Token "+PROFILE_TOKKEN_VALUE
            },
            body: json_str)
        .then((onValue) {
      print(onValue.body.toString());
      final Map<String, dynamic> arr = json.decode(onValue.body);
      if (arr["status"].toString().toLowerCase() == "1") {
        result = true;
      }
    });
    isLoading = false;
    return result;
  }

  /*
          dummy
        */
  /* Get Home Data */
  Future<void> getHomeDummy() async {
    bool result = false;
    app_config.questions = List<QuestioneirModel>();
    List<String> serial_numbers = List<String>();

    MainModel model = MainModel();

    await http.get(
        "http://localhost:8888/progdest/wow_feedback_dummy/dummy1.php",
        headers: {}).then((onValue) {
      //print(onValue.body.toString());
      //var arr=jsonDecode(onValue.body);
      final Map<String, dynamic> arr = json.decode(onValue.body);
      if (arr['status'] == 1) {
        Iterable question_list = arr["question"];
        for (var que in question_list) {
          var cur = AllQuestionsModel.fromJson(que);
          if (serial_numbers.contains(cur.serial)) {
            if (que["QuestionTypeID"] == 3 || que["QuestionTypeID"] == 4) {
              //app_config.nps=NpsModel.fromJson(que);
              //Smily question multiple -questionneire
              for (int i = 0; i < app_config.questions.length; i++) {
                if (app_config.questions[i].screen_number == cur.serial) {
                  app_config.questions[i].questions.add(cur);
                  break;
                }
              }
            }
          } else {
            serial_numbers.add(cur.serial);
            var questioneire_questions = List<AllQuestionsModel>();
            questioneire_questions.add(cur);
            var cur_question = QuestioneirModel(
                id: cur.id,
                screen_number: cur.serial,
                type: cur.type,
                multipleLanguage: cur.multipleLanguage,
                questions: questioneire_questions);
            app_config.questions.add(cur_question);
            /*if(que["QuestionTypeID"]==1){
                                                          //Smily question single - Smily

                                                      }
                                                    else if(que["QuestionTypeID"]==2){
                                                          //app_config.nps=NpsModel.fromJson(que);
                                                          //nps
                                                      } 
                                                    else if(que["QuestionTypeID"]==3){
                                                          //app_config.nps=NpsModel.fromJson(que);
                                                          //Smily question multiple -questionneire
                                                      }    
                                                    else if(que["QuestionTypeID"]==4){
                                                          //app_config.personal_questions.add(PersonalQuestionModel.fromJson(que));
                                                          ///Personal Questions
                                                      }*/
          }
        }
        notifyListeners();
      } else {}
    });
  }
}
