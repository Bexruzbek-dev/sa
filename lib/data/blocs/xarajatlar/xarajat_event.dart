import 'package:sa/models/xarajat.dart';

abstract class XarajatEvent {}

class AddXarajatEvent extends XarajatEvent {
  final String id;
  final double summa;
  final String category;
  final DateTime date;
  final String description;

  AddXarajatEvent(
    this.id,
    this.summa,
    this.category,
    this.date,
    this.description,
  );
}


class GetXarajatEvent extends XarajatEvent {

}



class EditXarajatEvent extends XarajatEvent {}
class LoadXarajatlarEvent extends XarajatEvent {}


class DeleteXarajatEvent extends XarajatEvent {
  String id;
  DeleteXarajatEvent({
   required this.id,
  });
}
