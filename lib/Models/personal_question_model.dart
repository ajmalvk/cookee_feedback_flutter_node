class PersonalQuestionModel{
      String id;
      int order;
      int multipleLanguage;
      String questionLanguage1;
      String questionLanguage2;
      PersonalQuestionModel({
            this.id,
            this.order,
            this.multipleLanguage,
            this.questionLanguage1,
            this.questionLanguage2
       });

       factory PersonalQuestionModel.fromJson(Map<String,dynamic> json){
          return PersonalQuestionModel(
                      id: json["QuestionID"].toString(),
                      order: 0,
                      multipleLanguage: json["HasMultiLanguage"],
                      questionLanguage1: json["QuestionL1"],
                      questionLanguage2: json["QuestionL2"]
                  );
        }  
  }