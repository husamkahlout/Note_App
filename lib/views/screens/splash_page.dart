import 'package:flutter/material.dart';
import 'package:notes_app/views/screens/notes_page.dart';
import '../../models/app_router.dart';
class SplachScreen extends StatelessWidget {
  initFun() async {
    await Future.delayed(const Duration(seconds: 3));
    await AppRouter.NavigateWithReplacementToWidget(NotesPage());
  }

  @override
  Widget build(BuildContext context) {
    initFun();
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          color: Colors.white,
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}