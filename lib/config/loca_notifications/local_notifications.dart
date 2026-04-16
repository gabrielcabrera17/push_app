import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//Este archivo despúes lo podremos copiar y pegar en otros desarrollos y funcionará perfectamente
class LocalNotifications {

  static Future<void> requestPermissionLocalNotifications() async {

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
}

  static Future<void> initializeLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    //TODO ios configurations

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      //TODO ios configurations settings
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      //TODO
      //onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse
    );
  }


}