import 'package:sa/models/daromad.dart';

abstract class DaromadEvent {}

class AddDaromadEvent extends DaromadEvent {
  final String id;
  final double summa;
  final String category;
  final DateTime date;
  final String description;

  AddDaromadEvent(
    this.id,
    this.summa,
    this.category,
    this.date,
    this.description,
  );
}


class GetDaromadEvent extends DaromadEvent {

}



class EditDaromadEvent extends DaromadEvent {}
class LoadDaromadlarEvent extends DaromadEvent {}


class DeleteDaromadEvent extends DaromadEvent {
  String id;
  DeleteDaromadEvent({
   required this.id,
  });
}
