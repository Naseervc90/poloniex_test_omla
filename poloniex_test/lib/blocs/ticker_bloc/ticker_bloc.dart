import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/ticker.dart';
import '../../services/web_socket_service.dart';

part 'ticker_event.dart';
part 'ticker_state.dart';

// Define your BLoC
class TickerBloc extends Bloc<TickerEvent, TickerState> {
  final WebSocketService webSocketService;
  StreamSubscription? _tickerSubscription;

  TickerBloc({required this.webSocketService}) : super(TickerInitial()) {
    on<FetchTicker>(_onFetchTicker);
    on<TickerUpdated>(_onTickerUpdated);
    on<ReceiveTickerInfo>(_onTickerInfoFetch);
  }

  void _onFetchTicker(FetchTicker event, Emitter<TickerState> emit) async {
    _tickerSubscription?.cancel();
    await webSocketService.requestToken();
    await webSocketService.connectToWebSocket();

    webSocketService.subscribeToTickerData();
    _tickerSubscription = webSocketService.tickerStream.listen(
      (ticker) {
        if (ticker != null) {
          add(TickerUpdated(ticker));
        }
      },
    );
  }

  void _onTickerUpdated(TickerUpdated event, Emitter<TickerState> emit) {
    // Handle the _TickerUpdated event
    final ticker = event.ticker;

    // Update the state based on the new ticker data
    emit(TickerUpdatedState(ticker));
  }

  void _onTickerInfoFetch(ReceiveTickerInfo event, Emitter<TickerState> emit) {
    final List<Ticker> list = [];
    emit(PriceChartState(list));
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
