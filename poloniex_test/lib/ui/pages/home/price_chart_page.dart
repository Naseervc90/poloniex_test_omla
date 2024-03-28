import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poloniex_test/blocs/bloc/price_chart_bloc.dart';

import '../../../models/ticker_model.dart';
// Adjust the path based on your project structure

class LoadTickerData extends PriceChartEvent {}

class PriceChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PriceChartBloc()..add(LoadTickerData()),
      child: BlocBuilder<PriceChartBloc, PriceChartState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Price Chart'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: true) as AxisTitles,
                    bottomTitles: SideTitles(showTitles: true) as AxisTitles,
                  ) as dynamic,
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: getSpots(state.tickerData),
                      isCurved: true,
                      //colors: [Colors.blue],
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<FlSpot> getSpots(List<Data> tickerData) {
    return tickerData
        .map((data) => FlSpot(
              data.ts, // Assuming ts represents the x-axis value
              data.price
                  .toDouble(), // Assuming price represents the y-axis value
            ))
        .toList();
  }
}

void main() {
  runApp(
    MaterialApp(
      home: PriceChartScreen(),
    ),
  );
}
