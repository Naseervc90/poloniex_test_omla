part of 'price_chart_bloc.dart';

// Event
abstract class PriceChartEvent extends Equatable {
  const PriceChartEvent();

  @override
  List<Object?> get props => [];
}

class LoadChart extends PriceChartEvent {}
