import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poloniex_test/models/ticker_model.dart';

part 'price_chart_event.dart';
part 'price_chart_state.dart';

class PriceChartBloc extends Bloc<PriceChartEvent, PriceChartState> {
  PriceChartBloc() : super(const PriceChartState([]));

  @override
  Stream<PriceChartState> mapEventToState(PriceChartEvent event) async* {
    if (event is LoadChart) {
      // Fetch data or load it from wherever you need
      final tickerData = await fetchData();
      yield PriceChartState(tickerData);
    }
  }

  // Replace this with actual data fetching logic
  Future<List<Data>> fetchData() async {
    // Implement your data fetching logic here
    return [];
  }
}
