import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserGetUsersEvent>(_onGetUser);
    on<UserGetJobEvent>(_onUserGetJobEvent);
  }

  _onGetUser(UserGetUsersEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final users = List.generate(event.count, (index) => User(name: "username", id: index.toString()));
    emit(state.copyWith(users: users));
  }

  _onUserGetJobEvent(UserGetJobEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final jobs = List.generate(event.count, (index) => Job(name: "Jobname", id: index.toString()));
    emit(state.copyWith(job: jobs));
  }

}
