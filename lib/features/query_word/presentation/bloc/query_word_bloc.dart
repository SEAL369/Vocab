import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class QueryWordBloc extends Bloc<QueryWordEvent, QueryWordState> {
  @override
  QueryWordState get initialState => InitialQueryWordState();

  @override
  Stream<QueryWordState> mapEventToState(
    QueryWordEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
