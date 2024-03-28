part of 'ticker_bloc.dart';

abstract class TickerState extends Equatable {}

class TickerInitial extends TickerState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class TickerLoaded extends TickerState {
  final Ticker ticker;
  TickerLoaded(this.ticker);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class TickerUpdatedState extends TickerState {
  final Ticker ticker;

  TickerUpdatedState(this.ticker);

  @override
  List<Object> get props => [ticker];
}

class TickerDataReceived extends TickerState {
  final String tickerInfo;

  TickerDataReceived(this.tickerInfo);

  @override
  // TODO: implement props
  List<Object?> get props => [tickerInfo];
}

class PriceChartState extends TickerState {
  final List<Ticker> tickerData;

  PriceChartState(this.tickerData);

  @override
  List<Object?> get props => [tickerData];
}
