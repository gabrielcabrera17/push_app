part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class NotificationsStatusChanged extends NotificationsEvent {
  final AuthorizationStatus status;

  NotificationsStatusChanged( this.status);
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//todo 2: NotificationReceived # PushMessage

class NotificationReceived extends NotificationsEvent{
  final PushMessage pushMessage;

  NotificationReceived(this.pushMessage);
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
