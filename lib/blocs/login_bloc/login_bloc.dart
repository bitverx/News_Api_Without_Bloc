import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'login_event.dart';
part 'login_state.dart';
class LoginBloc extends Bloc<LoginEvents,LoginState>{
  LoginBloc():super(const LoginState()){
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }
  void _onEmailChanged(EmailChanged event, Emitter<LoginState>emit){
    emit(
        state.copyWith(
          email: event.email,
        )
    );
  }
  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState>emit){
    emit(
        state.copyWith(
          email: event.password,
        )
    );
  }

}