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
