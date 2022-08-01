import 'package:flutter/material.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static NavigateToWidget(Widget widget) {
    Navigator.of(navKey.currentContext!).push(MaterialPageRoute(builder:((context) => widget)));
  }
  static NavigateWithReplacementToWidget(Widget widget) {
    Navigator.of(navKey.currentContext!).pushReplacement(MaterialPageRoute(builder:((context) => widget)));
  }
}
