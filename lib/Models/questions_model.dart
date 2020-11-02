class QuestionsModel{
      String id;
      int order;
      int multipleLanguage;
      String questionLanguage1;
      String questionLanguage2;
      int smileyCount;
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
      QuestionsModel({
          this.id,
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
          this.rateText5Language2
      });

      factory QuestionsModel.fromJson(Map<String,dynamic> json){
          return QuestionsModel(
                        id: json["QuestionID"],
                        order: 0,
                        multipleLanguage: int.parse(json["HasMultiLanguage"]),
                        questionLanguage1: json["QuestionL1"],
                        questionLanguage2: json["QuestionL2"],
                        smileyCount: int.parse(json["SmileyCount"]),
                        imageUrl1: json["ImageURL1"],
                        rateText1Language1: json["Rate1L1Text"],
                        rateText1Language2: json["Rate1L2Text"],
                        imageUrl2: json["ImageURL2"],
                        rateText2Language1: json["Rate2L1Text"],
                        rateText2Language2: json["Rate2L2Text"],
                        imageUrl3: json["ImageURL3"],
                        rateText3Language1: json["Rate3L1Text"],
                        rateText3Language2: json["Rate3L2Text"],
                        imageUrl4: json["ImageURL4"],
                        rateText4Language1: json["Rate4L1Text"],
                        rateText4Language2: json["Rate4L2Text"],
                        imageUrl5: json["ImageURL5"],
                        rateText5Language1: json["Rate5L1Text"],
                        rateText5Language2: json["Rate5L2Text"],
                  );
        }


  }