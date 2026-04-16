import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_app/config/loca_notifications/local_notifications.dart';
import 'package:push_app/domain/entities/push_message.dart';
import 'package:push_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}


class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(NotificationsState()) {

     on<NotificationsStatusChanged>(_notificationStatusChanged);

    //todo 3: crear el listener #_onPushMessageRecivied

    on<NotificationReceived>(_onPushMessageRecivied);

    //Verificar estado de las aplicaciones
    _initialStatusCheck();

    // Listener para notificaaciones en foreground
    _onForegroundMessage();
  }

  static Future<void> initializeFCM() async{
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChanged(NotificationsStatusChanged event, Emitter<NotificationsState> emit){
    emit(
      state.copyWith(
        status: event.status
      )
    );
    _getFCMToken();
  }

  void _onPushMessageRecivied(NotificationReceived event, Emitter<NotificationsState> emit){
    emit(
      state.copyWith(
        notifications: [event.pushMessage, ... state.notifications]
      )
    );
  }

  void _initialStatusCheck() async {
    //con este setting yo puedo saber el estado actual
    final settings = await messaging.getNotificationSettings();
    add(NotificationsStatusChanged(settings.authorizationStatus));
    _getFCMToken();

  }

  void _getFCMToken() async {
    final settings = await messaging.getNotificationSettings();
    if( state.status != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    print(token);
  }

  void handleRemoteMessage( RemoteMessage message){

    if (message.notification == null) return;

    final notification = PushMessage(
      messageId: message.messageId
        ?.replaceAll(':', '').replaceAll('%', '') 
        ?? '', 
      title: message.notification!.title ?? '', 
      body: message.notification!.body ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
      ? message.notification!.android?.imageUrl 
      : message.notification!.apple?.imageUrl
    );
      
      //TODO: add de un nuevo evento
     add(NotificationReceived(notification));
  }

  void _onForegroundMessage(){
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    //Solicitar permiso a las local Notifications
    await LocalNotifications.requestPermissionLocalNotifications();

    add(NotificationsStatusChanged(settings.authorizationStatus));
    _getFCMToken();
  }

  PushMessage?  getMessageById(String pushMessageId) {
    final exist = state.notifications.any((element) => element.messageId == pushMessageId);
    if(!exist) return null;

    return state.notifications.firstWhere((element) => element.messageId == pushMessageId,);
  }

}
