import 'package:flutter/material.dart';
import 'package:hive_test/app/app.dart';
import 'package:hive_test/app/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initModule();
  runApp(const App());
}
