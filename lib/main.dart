

import 'package:flutter/material.dart';
import 'package:rcapp/pages/MainPage.dart';
import 'package:rcapp/pages/HomePage.dart';
import 'package:rcapp/pages/Settings.dart';
import 'package:rcapp/pages/Error.dart';

void main()=> runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/' : (context)=> const HomePage(),
    '/mainpage' : (context)=> const MainPage(),
    '/Settings' : (context) => const Settings(),
    '/Error' : (context) =>Error(),
  },
));
