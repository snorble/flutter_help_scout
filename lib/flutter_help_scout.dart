import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

class FlutterHelpScout {
  static const MethodChannel _channel =
      const MethodChannel('privilee/flutter_help_scout');

  /// This is your beacon ID
  final String beaconId;

  FlutterHelpScout({required this.beaconId});

  /// This method will initialize the beacon.
  Future<String?> initialize() async {
    // On iOS we should call the 'open' method directly
    if (Platform.isIOS) {
      return 'OK';
    }
    var data = <String, dynamic>{
      'beaconId': beaconId,
    };

    try {
      final String? result = await _channel.invokeMethod(
        'initialize',
        data,
      );

      return result;
    } on PlatformException catch (e) {
      print('Unable to initialize beacon: ${e.toString()}');
    }
  }

  /// Once you’ve initialized Beacon, you’re ready to interact with it.
  /// Whenever you want to invoke Beacon, use the code below to
  /// display the Beacon user interface.

  Future<String?> open({String? beaconId}) async {
    var data = <String, dynamic>{
      'beaconId': beaconId ?? this.beaconId,
    };

    try {
      final String? result = await _channel.invokeMethod(
        'openBeacon',
        data,
      );

      return result;
    } on PlatformException catch (e) {
      print('Unable to open beacon: ${e.toString()}');
    }
  }


  /// Authenticates your user

  Future<String?> identify({
    String email = '',
      String name = '',
      String? avatar,
      Map<String, dynamic> attributes = const {},
  }) async {
    var data = <String, dynamic>{
      'email': email,
      'name': name,
      'avatar': avatar,
      'attribute': attributes
    };

    try {
      final String? result = await _channel.invokeMethod(
        'identifyBeacon',
        data,
      );

      return result;
    } on PlatformException catch (e) {
      print('Unable to identify the user: ${e.toString()}');
    }
  }

  /// Calling this method resets the current Beacon state,
  /// thereby deleting all the user data: email, name, user attributes,
  /// push token and resets the Beacon Device ID. It won’t
  /// remove the Beacon ID, or any local config overrides.

  Future<String?> logout() async {
    try {
      final String? result = await _channel.invokeMethod(
        'logoutBeacon',
      );

      return result;
    } on PlatformException catch (e) {
      print('Unable to open beacon: ${e.toString()}');
    }
  }

  /// This method wipes all data from the Beacon,
  /// including the Beacon ID. This may be useful if
  /// you are using different Beacons in different parts of your app.

  Future<String?> clear() async {
    try {
      final String? result = await _channel.invokeMethod(
        'clearBeacon',
      );

      return result;
    } on PlatformException catch (e) {
      print('Unable to open beacon: ${e.toString()}');
    }
  }

  Future<String?> openContact(String beaconId) async {
    try {
      final data = <String, dynamic>{
        'beaconId': beaconId,
      };

      final String? result = await _channel.invokeMethod('openContact', data);

      return result;
    } on PlatformException catch (e) {
      print('Unable to open beacon: ${e.toString()}');
    }
  }
}
