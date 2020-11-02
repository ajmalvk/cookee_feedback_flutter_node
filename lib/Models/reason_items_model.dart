class ReasonItemsModel{
      String id;
      String questionId;
      String answerLanguage1;
      String answerLanguage2;
      bool selected=false;
      ReasonItemsModel({
            this.id,
            this.questionId,
            this.answerLanguage1,
            this.answerLanguage2,
       });

       factory ReasonItemsModel.fromJson(Map<String,dynamic> json){
          return ReasonItemsModel(
                      id: json["ReasonAnswerID"].toString(),
                      questionId: json["ReasonQuestionID"].toString(),
                      answerLanguage1: json["AnswerL1"].toString(),
                      answerLanguage2: json["AnswerL2"].toString()
                  );
        }  
  }