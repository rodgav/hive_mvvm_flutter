import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_test/app/dependency_injection.dart';
import 'package:hive_test/presentation/home/home.dart';

class Routes {
  static const homeRoute = '/';
}

class RouteManager {
  static final router = GoRouter(
      routes: [
        GoRoute(
            path: Routes.homeRoute,
            builder: (_, state) {
              initHomeModule();
              return const HomeView();
            })
      ],
      errorBuilder: (context, __) => unDefinedRoute(context),
      routerNeglect: true,
      initialLocation: Routes.homeRoute,
      debugLogDiagnostics: true);

  static unDefinedRoute(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
    );
  }
}
