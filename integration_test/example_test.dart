import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:quitsmoke/main.dart';
import 'package:quitsmoke/patrol_keys.dart';

void main() {
  patrolTest(
    'counter state is the same after going to home and switching apps',
    nativeAutomation: true,
    ($) async {
      await prepare();
      await $.pumpWidgetAndSettle(MyApp());

      await $(K.quitingReasonTextField).enterText("It's bad for my health");
      await $(K.addToListButton).tap();
      await $(K.quitingReasonTextField).enterText("It smells bad...");
      await $(K.addToListButton).scrollTo();
      await $(K.quitingReasonTextField)
          .enterText("I'm scared of getting cancer.");
      await $(K.addToListButton).scrollTo();
      await $(K.quitingReasonTextField).enterText("It costs too much");
      await $(K.addToListButton).scrollTo();
      await $(K.mainPaigeNextButton).tap();
      await $(K.quitingReasonTextField).enterText('9');
      await $(K.costTextField).enterText('1');
      await Future.delayed(Duration(seconds: 5));
    },
  );
}
