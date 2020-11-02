library app_config.dart;
import 'package:feedback/Models/questioneir_model.dart';
import 'package:feedback/Models/reason_items_model.dart';

String app_title="Wow Feedback";
String userTokken="";
List<QuestioneirModel> questions = List<QuestioneirModel>();
List<QuestioneirModel> questions_org = List<QuestioneirModel>();
String company_name="";
String company_phone="";
String company_phone2="";
String company_fax="";
String company_email="";
String company_website="";
String company_address="";
String company_logo="";
bool company_logo_exist=false;
bool has_multi_language = false;
String language1="";
String language2="";
bool load_home_data=true;
String thank_you_image="";
String thank_you_text="";
bool thank_you_image_exist=false;
List<ReasonItemsModel> reasons=List<ReasonItemsModel>();
String reason_question_language1="";
String reason_question_language2="";
String web_url="";
String logo_url_image_baseurl = "";
String thanks_url_image_baseurl ="";
String api_url="";




