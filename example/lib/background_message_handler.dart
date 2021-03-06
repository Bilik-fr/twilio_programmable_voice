import 'package:twilio_programmable_voice/twilio_programmable_voice.dart';

Future<void> backgroundMessageHandler(dynamic message) async {
  // It's a data
  if (message.containsKey("data") && message["data"] != null) {
    // It's a twilio data message
    print("In APP listener Message contains data");
    if (message["data"].containsKey("twi_message_type")) {
      print("Message is a Twilio Message : ");

      final dataMap = Map<String, String>.from(message["data"]);

      print('Data : ' + dataMap.toString());

      // Handle Twilio Message
      await TwilioProgrammableVoice.instance.handleMessage(data: dataMap);
      final tmpTest = await TwilioProgrammableVoice.instance.testIos();
      print('tmpTest : $tmpTest');
    }
  }
}

// And old version callBackDispatcher
// I think it does to many things
// but even the little one doesn't work

// import 'package:callkeep/callkeep.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:twilio_programmable_voice/twilio_programmable_voice.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'utils/callkeep_config.dart';
//
// final FlutterCallkeep _callKeep = FlutterCallkeep();
// bool _callKeepInited = false;
//
// Future<dynamic> backgroundMessageHandler(Map<String, dynamic> message) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load('.env');
//   final accessTokenUrl = dotenv.env['ACCESS_TOKEN_URL'];
//   // It's a data
//   if (message.containsKey("data") && message["data"] != null) {
//     // It's a twilio data message
//     print("Message contains data");
//     if (message["data"].containsKey("twi_message_type")) {
//       final tmpTest = await FirebaseMessaging().getToken();
//       print("Message is a Twilio Message v6, ... $tmpTest");
//
//       final dataMap = Map<String, String>.from(message["data"]);
//       // await TwilioProgrammableVoice.instance.setUp(accessTokenUrl: accessTokenUrl);
//
//       await TwilioProgrammableVoice.instance.handleMessage(data: dataMap);
//       print(TwilioProgrammableVoice.instance.getCall.toString());
//       final callUUID = TwilioProgrammableVoice.instance.getCall.sid;
//
//       _callKeep.on(CallKeepPerformAnswerCallAction(),
//               (CallKeepPerformAnswerCallAction event) async {
//             print(
//                 'backgroundMessage: CallKeepPerformAnswerCallAction ${event.callUUID}');
//
//             _callKeep.startCall(event.callUUID, TwilioProgrammableVoice.instance.getCall.from, "callerName");
//
//             await TwilioProgrammableVoice.instance.setUp(accessTokenUrl: accessTokenUrl);
//             await TwilioProgrammableVoice.instance.handleMessage(data: dataMap);
//             await TwilioProgrammableVoice.instance.answer();
//
//             _callKeep.setCurrentCallActive(callUUID);
//           });
//
//       _callKeep.on(CallKeepPerformEndCallAction(),
//               (CallKeepPerformEndCallAction event) async {
//             print(
//                 'backgroundMessage: CallKeepPerformEndCallAction ${event.callUUID}');
//
//             await TwilioProgrammableVoice.instance.setUp(accessTokenUrl: accessTokenUrl);
//             await TwilioProgrammableVoice.instance.handleMessage(data: dataMap);
//             await TwilioProgrammableVoice.instance.reject();
//           });
//
//       if (!_callKeepInited) {
//         _callKeep.setup(callKeepSetupConfig);
//         _callKeepInited = true;
//       }
//
//       _callKeep.displayIncomingCall(callUUID, "number");
//       _callKeep.backToForeground();
//
//       // TODO: Make sure the accessToken is still valid ?
//       // We can't handle message here, need to create the call screen first
//       // TwilioProgrammableVoice.instance.handleMessage(dataMap);
//       print("handleMessage called in main.dart");
//     }
//   }
//
//   if (message.containsKey('notification')) {
//     // Handle notification message
//     final dynamic notification = message['notification'];
//   }
//
//   // Or do other work.
// }