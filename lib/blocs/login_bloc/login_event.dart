part of 'login_bloc.dart';
abstract class LoginEvents extends Equatable{
  const LoginEvents();
  @override
  List<Object>get pros => [];
}
class EmailUnfocus extends LoginEvents{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class EmailChanged extends LoginEvents{
  const EmailChanged({required this.email});
  final String email;
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class PasswordChanged extends LoginEvents{
  const PasswordChanged({required this.password});
  final String password;
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class PasswordUnfocus extends LoginEvents{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class SubmitButton extends LoginEvents{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}