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
  //Para mostrar el local Notification debo pedir ciertos datos
  static Future<void> showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? data
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'channelId', 
      'channelName',
      //Si quieres agregar un sonido personalizado, ir en app>src>main>res>raw (crear directorio raw si no existe) y dentro alojar el sonido
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
      //configurar importancia de la notificación
      importance: Importance.max,
      priority: Priority.high

    );
  
    // obtener los detalles de la notificación
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      // TODO IOS
    );


    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.show(id:id, title: title, body: body, notificationDetails: notificationDetails, payload: data);

  }


}