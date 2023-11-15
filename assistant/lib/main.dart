import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';

import 'src/provider/counter.dart';
import 'src/provider/setting.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
      ChangeNotifierProvider(create: (_) => Setting()),
    ],
    child: const MyApp(),
  ));
}
