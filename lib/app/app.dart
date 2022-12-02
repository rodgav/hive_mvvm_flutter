import 'package:flutter/material.dart';
import 'package:hive_test/presentation/resources/router_manager.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: RouteManager.router.routeInformationProvider,
      routerDelegate: RouteManager.router.routerDelegate,
      routeInformationParser: RouteManager.router.routeInformationParser,
    );
  }
}
