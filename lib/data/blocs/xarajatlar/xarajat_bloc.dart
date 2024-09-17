import 'package:bloc/bloc.dart';
import 'package:sa/data/blocs/xarajatlar/xarajat_event.dart';
import 'package:sa/data/blocs/xarajatlar/xarajat_state.dart';
import 'package:sa/data/repositories/xarajatlar_repository.dart';
import 'package:sa/models/xarajat.dart';

class XarajatBloc extends Bloc<XarajatEvent, XarajatState> {
  final XarajatlarRepository xarajatRepository;

  XarajatBloc({required this.xarajatRepository}) : super(XarajatInitial()) {
    on<AddXarajatEvent>(_onAddXarajat);
    on<GetXarajatEvent>(_onGetXarajat);
    on<DeleteXarajatEvent>(_onDelete);
    on<LoadXarajatlarEvent>((event, emit) async {
      try {
        emit(XarajatLoading());
        final xarajatlar = await xarajatRepository.getXarajatlar();
        emit(
          XarajatLoaded(
            xarajatlar: xarajatlar,
          ),
        );
      } catch (e) {
        print(e);
        emit(XarajatError('Failed to load xarajats '));
      }
    });
    add(LoadXarajatlarEvent());
  }

  Future<void> _onAddXarajat(
      AddXarajatEvent event, Emitter<XarajatState> emit) async {
    emit(XarajatLoading());
    try {
      await xarajatRepository.addXarajat(
        Xarajat(
          id: event.id,
          summa: event.summa,
          category: event.category,
          date: event.date,
          description: event.description,
        ),
      );
      final xarajatlar = await xarajatRepository.getXarajatlar();

      emit(XarajatLoaded(xarajatlar: xarajatlar));
    } catch (e) {
      emit(XarajatError(e.toString()));
    }
  }

  Future<void> _onGetXarajat(
      GetXarajatEvent event, Emitter<XarajatState> emit) async {
    try {
      emit(XarajatLoading());
      await xarajatRepository.getXarajatlar();
      final xarajatlar = await xarajatRepository.getXarajatlar();

      emit(XarajatLoaded(xarajatlar: xarajatlar));
    } catch (e) {
      emit(XarajatError(e.toString()));
    }
  }

  Future<void> _onDelete(
      DeleteXarajatEvent event, Emitter<XarajatState> emit) async {
    emit(XarajatLoading());
    await xarajatRepository.delete(event.id);
    final xarajatlar = await xarajatRepository.getXarajatlar();
    emit(XarajatLoaded(xarajatlar: xarajatlar));
  }
}
