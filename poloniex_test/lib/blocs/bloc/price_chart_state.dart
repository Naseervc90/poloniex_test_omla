part of 'price_chart_bloc.dart';

// State
class PriceChartState extends Equatable {
  final List<Data> tickerData;

  const PriceChartState(this.tickerData);

  @override
  List<Object?> get props => [tickerData];
}
