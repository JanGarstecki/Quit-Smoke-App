import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:quitsmoke/notification_manager.dart';
import 'package:quitsmoke/screens/splash_screen.dart';
import 'package:quitsmoke/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await prepare();

  runApp(MyApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void onError_ignoreOverflowErrors(
  FlutterErrorDetails details, {
  bool forceReport = false,
}) {
  assert(details != null);
  assert(details.exception != null);

  var isOverflowError = false;

  // Detect overflow error.
  var exception = details.exception;
  if (exception is FlutterError) {
    isOverflowError = exception.diagnostics
        .any((e) => e.value.toString().contains("A RenderFlex overflowed by"));
  }

  // Ignore if is overflow error: only report to the console, but do not throw exception as it will
  // cause widget tests to fail.
  if (isOverflowError) {
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
  } else {
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
    throw (exception);
  }
}

Future<void> prepare() async {
  await _configureLocalTimeZone();

  Intl.defaultLocale = Platform.localeName;
  initializeDateFormatting(Platform.localeName, null);
  NotificationManager.initializeLocalNotifiations();
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.clear();

  FlutterError.onError = onError_ignoreOverflowErrors;
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        title: 'Quit Smoking',
        theme: themeData(context),
        home: SplashScreen(),
        darkTheme: darkThemeData(context),
        themeMode: ThemeMode.light,
      ),
    );
  }
}
