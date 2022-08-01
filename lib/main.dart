import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/app_router.dart';
import 'views/screens/notes_page.dart';
import 'views/screens/splash_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
    runApp(
       EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ar')],
          path:'assets/translations', // <-- change the path of the translation files
          fallbackLocale: Locale('en'),
          child: MyApp()),
    );

}

class MyApp extends StatelessWidget {
  static final String title = 'Notes App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:AppRouter.navKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Color.fromARGB(255, 24, 24, 24),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: SplachScreen(),
    );
  }
}
