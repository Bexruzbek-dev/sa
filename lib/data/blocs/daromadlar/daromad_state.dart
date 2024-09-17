

import 'package:sa/models/daromad.dart';

abstract class DaromadState{}

class DaromadInitial extends DaromadState {}

class DaromadLoading extends DaromadState {}

class DaromadLoaded extends DaromadState {
 List<Daromad> daromadlar = [];
 DaromadLoaded({
  required this.daromadlar
 });
}

class DaromadError extends DaromadState {
  final String message;
  DaromadError(this.message);
}