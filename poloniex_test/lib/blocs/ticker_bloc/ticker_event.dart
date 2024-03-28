part of 'ticker_bloc.dart';

// Define your events and states
abstract class TickerEvent extends Equatable {}

class FetchTicker extends TickerEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class TickerUpdated extends TickerEvent {
  final Ticker ticker;

  TickerUpdated(this.ticker);

  @override
  List<Object> get props => [ticker];
}

class ReceiveTickerInfo extends TickerEvent {
  final String tickerInfo;

  ReceiveTickerInfo(this.tickerInfo);

  @override
  // TODO: implement props
  List<Object?> get props => [tickerInfo];
}
