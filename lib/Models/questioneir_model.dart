import 'package:feedback/Models/all_questions_model.dart';
class QuestioneirModel{
      String id;
      String screen_number;
      String type;
      int multipleLanguage;
      List<AllQuestionsModel> questions;
      QuestioneirModel({this.id,this.screen_number,this.type,this.multipleLanguage,this.questions});
  }