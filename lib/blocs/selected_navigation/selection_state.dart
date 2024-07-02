part of 'selection_bloc.dart';
class  SelectionState extends Equatable{
  final int selectedIndex;
  SelectionState({this.selectedIndex = -1});
  SelectionState copyWith({int? selectedIndex}){
    return SelectionState(
        selectedIndex: selectedIndex ?? this.selectedIndex
    );
  }

  @override
  List<Object?> get props =>[selectedIndex];

}