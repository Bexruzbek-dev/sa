

import 'package:sa/models/xarajat.dart';

abstract class XarajatState{}

class XarajatInitial extends XarajatState {}

class XarajatLoading extends XarajatState {}

class XarajatLoaded extends XarajatState {
 List<Xarajat> xarajatlar = [];
 XarajatLoaded({
  required this.xarajatlar
 });
}

class XarajatError extends XarajatState {
  final String message;
  XarajatError(this.message);
}