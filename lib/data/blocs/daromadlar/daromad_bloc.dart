import 'package:bloc/bloc.dart';
import 'package:sa/data/blocs/daromadlar/daromad_event.dart';
import 'package:sa/data/blocs/daromadlar/daromad_state.dart';
import 'package:sa/data/repositories/daromadlar_repository.dart';
import 'package:sa/models/daromad.dart';

class DaromadBloc extends Bloc<DaromadEvent, DaromadState> {
  final DaromadlarRepository daromadRepository;

  DaromadBloc({required this.daromadRepository}) : super(DaromadInitial()) {
    on<AddDaromadEvent>(_onAddDaromad);
    on<GetDaromadEvent>(_onGetDaromad);
    on<DeleteDaromadEvent>(_onDelete);
    on<LoadDaromadlarEvent>((event, emit) async {
      try {
        emit(DaromadLoading());
        final daromadlar = await daromadRepository.getDaromadlar();
        emit(
          DaromadLoaded(
            daromadlar: daromadlar,
          ),
        );
      } catch (e) {
        print(e);
        emit(DaromadError('Failed to load daromads '));
      }
    });
    add(LoadDaromadlarEvent());
  }

  Future<void> _onAddDaromad(
      AddDaromadEvent event, Emitter<DaromadState> emit) async {
    emit(DaromadLoading());
    try {
      await daromadRepository.addDaromad(
        Daromad(
          id: event.id,
          summa: event.summa,
          category: event.category,
          date: event.date,
          description: event.description,
        ),
      );
      final daromadlar = await daromadRepository.getDaromadlar();

      emit(DaromadLoaded(daromadlar: daromadlar));
    } catch (e) {
      emit(DaromadError(e.toString()));
    }
  }

  Future<void> _onGetDaromad(
      GetDaromadEvent event, Emitter<DaromadState> emit) async {
    try {
      emit(DaromadLoading());
      await daromadRepository.getDaromadlar();
      final daromadlar = await daromadRepository.getDaromadlar();

      emit(DaromadLoaded(daromadlar: daromadlar));
    } catch (e) {
      emit(DaromadError(e.toString()));
    }
  }

  Future<void> _onDelete(
      DeleteDaromadEvent event, Emitter<DaromadState> emit) async {
    emit(DaromadLoading());
    await daromadRepository.delete(event.id);
    final daromadlar = await daromadRepository.getDaromadlar();
    emit(DaromadLoaded(daromadlar: daromadlar));
  }
}
