part of 'login_bloc.dart';
class LoginState extends Equatable{
  const LoginState({
    this.email=(''),
    this.password=(''),
  });
  final String email;
  final String password;

  LoginState copyWith({
    String? email,
    String? password,
  }){
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [email,password];

}
