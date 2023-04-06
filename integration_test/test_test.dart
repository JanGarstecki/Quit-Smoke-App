import 'package:flutter/services.dart';
import 'package:patrol/patrol.dart';
import 'package:quitsmoke/main.dart';

void main() {
  patrolTest(
    'demo',
    (PatrolTester $) async {
      await prepare();
      await $.pumpWidgetAndSettle(MyApp());
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      // prepare network conditions
      await $.native.enableCellular();
    },
    nativeAutomation: true,
  );
}
