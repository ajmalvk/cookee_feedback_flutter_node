import 'package:feedback/Utitlity/constants.dart';
import 'package:feedback/Utitlity/app_config.dart' as app_config;
class AllQuestionsModel{
      String id;
      String serial;
      String type;
      int order;
      int multipleLanguage;
      String questionLanguage1;
      String questionLanguage2;
      String smileyCount;
      String imageUrl1;
      String rateText1Language1;
      String rateText1Language2;
      String imageUrl2;
      String rateText2Language1;
      String rateText2Language2;
      String imageUrl3;
      String rateText3Language1;
      String rateText3Language2;
      String imageUrl4;
      String rateText4Language1;
      String rateText4Language2;
      String imageUrl5;
      String rateText5Language1;
      String rateText5Language2;
      String startTextLanguage1;
      String startTextLanguage2;
      String endTextLanguage1;
      String endTextLanguage2;
      String answer;
      String fieldId;
      AllQuestionsModel({
          this.id,
          this.serial,
          this.type,
          this.order,
          this.multipleLanguage,
          this.questionLanguage1,
          this.questionLanguage2,
          this.smileyCount,
          this.imageUrl1,
          this.rateText1Language1,
          this.rateText1Language2,
          this.imageUrl2,
          this.rateText2Language1,
          this.rateText2Language2,
          this.imageUrl3,
          this.rateText3Language1,
          this.rateText3Language2,
          this.imageUrl4,
          this.rateText4Language1,
          this.rateText4Language2,
          this.imageUrl5,
          this.rateText5Language1,
          this.rateText5Language2,
          this.startTextLanguage1,
          this.startTextLanguage2,
          this.endTextLanguage1,
          this.endTextLanguage2,
          this.fieldId
      });

      factory AllQuestionsModel.fromJson(Map<String,dynamic> json){
          return AllQuestionsModel(
                        id: json["QuestionID"].toString(),
                        serial: json["SlNo"].toString(),
                        type: json["QuestionTypeID"].toString(),
                        order: 0,
                        multipleLanguage: parseBoolInt(json["HasMultiLanguage"].toString()),
                        questionLanguage1: json["QuestionL1"],
                        questionLanguage2: json["QuestionL2"],
                        smileyCount: json["SmileyCount"].toString(),
                        imageUrl1: parseImage(json["ImageURL1"].toString()),
                        rateText1Language1: json["Rate1L1Text"],
                        rateText1Language2: json["Rate1L2Text"],
                        imageUrl2: parseImage(json["ImageURL2"].toString()),
                        rateText2Language1: json["Rate2L1Text"],
                        rateText2Language2: json["Rate2L2Text"],
                        imageUrl3: parseImage(json["ImageURL3"].toString()),
                        rateText3Language1: json["Rate3L1Text"],
                        rateText3Language2: json["Rate3L2Text"],
                        imageUrl4: parseImage(json["ImageURL4"].toString()),
                        rateText4Language1: json["Rate4L1Text"],
                        rateText4Language2: json["Rate4L2Text"],
                        imageUrl5: parseImage(json["ImageURL5"]),
                        rateText5Language1: json["Rate5L1Text"],
                        rateText5Language2: json["Rate5L2Text"],
                        startTextLanguage1: json["StartL1Text"],
                        startTextLanguage2: json["StartL2Text"],
                        endTextLanguage1: json["EndL1Text"],
                        endTextLanguage2: json["EndL2Text"],
                        fieldId: json["FieldID"].toString()
                  );
        }

      static int parseBoolInt(String json){
          var result=0;
          if(json.toLowerCase()=="true"){
                result=1;
            }
          return result;
        }  

      static String parseImage(String json){
            if(json != "" && json != "null" && json != null){
                  json = app_config.web_url+json;
              }
            else{
                  json="";
              }  
            return json;  
        }  


  }