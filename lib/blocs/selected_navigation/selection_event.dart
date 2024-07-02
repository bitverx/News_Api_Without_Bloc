part of 'selection_bloc.dart';
abstract class SelectionEvent extends Equatable{
  const SelectionEvent();
  @override
  List<Object?> get pros => [];
}
class ItemSelected extends SelectionEvent{
  final int index;
  ItemSelected(this.index);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}