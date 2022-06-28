import 'package:blocfirebaseauth/Bloc/app/app_bloc.dart';
import 'package:blocfirebaseauth/Screens/home_screen.dart';
import 'package:blocfirebaseauth/Screens/login_screen.dart';
import 'package:flutter/material.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];
    case AppStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
