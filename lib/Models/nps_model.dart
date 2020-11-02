class NpsModel{
      String id;
      int multipleLanguage;
      String questionLanguage1;
      String questionLanguage2;
      String startTextLanguage1;
      String startTextLanguage2;
      String endTextLanguage1;
      String endTextLanguage2;
      NpsModel({
          this.id,
          this.multipleLanguage,
          this.questionLanguage1,
          this.questionLanguage2,
          this.startTextLanguage1,
          this.startTextLanguage2,
          this.endTextLanguage1,
          this.endTextLanguage2
      });

      factory NpsModel.fromJson(Map<String,dynamic> json){
          return NpsModel(
                        id: json["QuestionID"],
                        multipleLanguage: int.parse(json["HasMultiLanguage"]),
                        startTextLanguage1: json["Rate1L1Text"],
                        startTextLanguage2: json["Rate1L2Text"],
                        endTextLanguage1: json["Rate1L1Text"],
                        endTextLanguage2: json["Rate1L2Text"],
                  );
        }
  }