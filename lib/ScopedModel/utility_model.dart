import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';

mixin UtilityModel on Model{
        ///getting current date
        String getCurrentDate(){
              var now = new DateTime.now();
              new DateFormat("dd-MMM-yyyy").format(now);
              var day = getDayName(DateFormat("dd").format(now));
              var month = DateFormat("MM").format(now);
              var year = DateFormat("yyyy").format(now);
              var month_name = getMonthName(month);
              return day+" "+month_name+" "+year; 
          }

        ///get day with th 
        String getDayName(String day){
              int cur=int.parse(day);
              if(cur==1){
                  day+="st";
                }
              else if(cur==2){
                  day+="nd";
                }
              else if(cur==3){
                  day+="rd"; 
                } 
              else{
                  day+="th";
                } 
              return day;      
          }  
        
        String getMonthName(String month){
              String mnth="";
              switch (month) {
                    case "1":
                      mnth="January";
                      break;
                    case "2":
                      mnth="February";
                      break;
                    case "3":
                      mnth="March";
                      break;
                    case "4":
                     mnth="April";
                      break;
                    case "5":
                      mnth="May";
                      break;
                    case "6":
                      mnth="June";
                      break;
                    case "7":
                      mnth="July";
                      break;
                    case "8":
                      mnth="August";
                      break;
                    case "9":
                      mnth="September";
                      break;
                    case "10":
                      mnth="October";
                      break;
                    case "11":
                      mnth="November";
                      break;
                    case "12":
                      mnth="December";
                      break;
                  }
              return mnth;    
          }
  }