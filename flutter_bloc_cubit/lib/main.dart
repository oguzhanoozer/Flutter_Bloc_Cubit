import 'package:flutter/material.dart';

import 'basic/features/login/view/login_view.dart';
import 'basic/features/travel/view/travel_tab_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData.light().copyWith(
          tabBarTheme: TabBarTheme(
            labelColor: Colors.orange,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: const BoxDecoration(),
            unselectedLabelColor: Colors.grey.withOpacity(0.3),
          ),
        ),
        home: LoginView());
  }
}
