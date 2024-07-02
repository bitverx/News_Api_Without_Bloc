import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selection_event.dart';
part 'selection_state.dart';

class SelectionBloc extends Bloc<SelectionEvent, SelectionState> {
  SelectionBloc() : super( SelectionState()) {
    on<ItemSelected>(_onItemSelected);
  }

  void _onItemSelected(ItemSelected event, Emitter<SelectionState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }
}
