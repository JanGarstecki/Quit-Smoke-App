import 'package:flutter/material.dart';
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
      await $(K.addToListButton).scrollTo().tap();
      await $(K.quitingReasonTextField).enterText("It smells bad...");
      await $(K.addToListButton).scrollTo().tap();
      await $(K.quitingReasonTextField)
          .enterText("I'm scared of getting cancer.");
      await $(K.addToListButton).scrollTo().tap();
      await $(K.quitingReasonTextField).enterText("It costs too much");
      await $(K.addToListButton).scrollTo().tap();
      await $(K.mainPaigeNextButton).scrollTo().tap();
      await $(K.numOfCigsTextField).enterText('9');
      await $(K.costTextField).enterText('1');
      await $(K.chooseCurrencyDropdown).scrollTo().tap();
      await $(RegExp('Euro'))
          .scrollTo(
              scrollable: $(CustomSingleChildLayout).$(Scrollable),
              maxScrolls: 150)
          .tap();
      await $(K.changeDateButton).scrollTo().tap();
      await $(Icons.edit).tap();
      await $(TextField).enterText('01/07/2020');
      await $(RegExp('OK')).tap();
      await $(RegExp('OK')).tap();
      await $(K.mainPaigeNextButton).scrollTo().tap(andSettle: true);
      await $(K.startNowButton).tap(andSettle: true);
      await $(Key('wallet')).tap();
    },
  );
}
