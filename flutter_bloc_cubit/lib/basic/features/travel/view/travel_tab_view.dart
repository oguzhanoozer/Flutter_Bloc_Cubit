import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'travel_view.dart';

enum _travelPages { home, bookmarks, notification, profile }

class TravelTabView extends StatelessWidget {
  const TravelTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _travelPages.values.length,
        child: Scaffold(
            bottomNavigationBar: BottomAppBar(
                child: TabBar(
                    tabs: [Tab(icon: Icon(Icons.snowing)), Tab(icon: Icon(Icons.ad_units)), Tab(icon: Icon(Icons.ad_units)), Tab(icon: Icon(Icons.ad_units))])),
            body: TabBarView(
              children: [
                TravelView(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
              ],
            )));
  }
}
