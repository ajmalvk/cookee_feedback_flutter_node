import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:feedback/Utitlity/constants.dart';
import 'dart:async';

mixin PreferenceModel on Model{
        Future<String> getAccessTokken() async{
                 SharedPreferences prefs = await SharedPreferences.getInstance();
                 return prefs.getString(PREFERENCE_TOKKEN_KEY) ?? "";
            }
        Future<void> setAccessTokken(String tokken) async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString(PREFERENCE_TOKKEN_KEY, tokken);

          }    

        Future<String> getApiUrl() async{
                 SharedPreferences prefs = await SharedPreferences.getInstance();
                 return prefs.getString('base_url') ?? "";
            }
        Future<void> setApiUrl(String tokken) async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('base_url', tokken);

          }      

         Future<String> getWebUrl() async{
                 SharedPreferences prefs = await SharedPreferences.getInstance();
                 return prefs.getString('web_url') ?? "";
            }

        Future<void> setWebUrl(String tokken) async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('web_url', tokken);

          }        
  }