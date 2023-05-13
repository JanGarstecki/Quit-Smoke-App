import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:quitsmoke/main.dart';

void main() {
  patrolTest(
    'counter state is the same after going to home and switching apps',
    nativeAutomation: true,
    ($) async {
      await prepare();
      await $.pumpWidgetAndSettle(MyApp());

      await $('quit').enterText('It stinks');
    },
  );
}
